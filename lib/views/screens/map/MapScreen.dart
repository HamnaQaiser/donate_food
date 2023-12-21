import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_donation_app/components/GradientButton.dart';
import 'package:food_donation_app/components/searchField.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/utility/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //get current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _initialPosition = LatLng(32.5749544,74.0896053);
  final TextEditingController searchController = TextEditingController();

  String newAddress = '';
  var long, lat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<Marker> _markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationController>(context, listen: true);
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _determinePosition().then((value) async {
                  // add marker into local list
                  provider.UpdateLocation(
                      newAddress, value.longitude, value.latitude);
                  // create new camera position to animate
                  CameraPosition camera = CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 14);
                  GoogleMapController controller = await _controller.future;
                  setState(() {
                    controller
                        .animateCamera(CameraUpdate.newCameraPosition(camera));
                  });//
                });
              },
              backgroundColor: mainColor,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        body: Stack(
          children: [
            loadMap(),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchField(
                    controller: searchController,
                    label: 'Search',
                    onTap: () {},
                  ),
                  GradientButton(
                      label: 'Set Location',
                      onPress: () {
                        provider.UpdateLocation(newAddress, long, lat);
                      },
                      loading: false)
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: searchController.text == ''
                    ? Container()
                    : Image(
                        image: AssetImage(
                          'asset/marker.png',
                        ),
                        height: 15,
                      ))
          ],
        ));
  }

  Widget loadMap() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            _markers.add(Marker(
                markerId: MarkerId(
                  i.toString(),
                ),
                position: LatLng(snapshot.data!.docs[i]['lat'],
                    snapshot.data!.docs[i]['long']),
                infoWindow:
                    InfoWindow(title: snapshot.data!.docs[i]['place'])));
          }
          return GoogleMap(
            markers: Set<Marker>.of(_markers),
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (val) async {
              List<Placemark> _placemark = await placemarkFromCoordinates(
                  val.target.latitude, val.target.longitude);

              setState(() {
                lat = val.target.latitude;
                long = val.target.longitude;
                newAddress =
                    '${_placemark.reversed.last.street.toString()}, ${_placemark.reversed.last.administrativeArea.toString()}';

                searchController.text = newAddress;
              });
              print('Long:' + val.target.longitude.toString());
            },
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 14),
          );
        });
  }
}
