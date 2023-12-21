import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_donation_app/utility/constants.dart';

import '../../components/InputField.dart';


class NGOHomeScreen extends StatefulWidget {
  const NGOHomeScreen({Key? key}) : super(key: key);

  @override
  State<NGOHomeScreen> createState() => _NGOHomeScreenState();
}

class _NGOHomeScreenState extends State<NGOHomeScreen> {
  final searchController = TextEditingController();
  final searchNode = FocusNode();
  late Stream<QuerySnapshot> restaurantsStream;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurantsStream = FirebaseFirestore.instance
        .collection('Users')
        .where('role', isEqualTo: 'Restaurant')
        .snapshots();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Request for Food',
        style: paragraph.copyWith(color: mainColor, fontSize: 22),
      ),
    ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InputField(
                controller: searchController,
                keyboardType: TextInputType.text,
                validator: (val) {
                  return null;
                },
                focusNode: searchNode,
                icon: Icons.search,
                label: 'Search for Restaurants'),
          ),

          CarouselSlider(
            items: [
              Container(
                color: Colors.grey.shade100,
                child: Image(
                  image: AssetImage('./././asset/carousal_img_5.jpg'),
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Container(
                color: Colors.grey.shade100,
                child: Image(
                  image: AssetImage(
                    './././asset/carousal_img_6.jpg',
                  ),
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Container(
                color: Colors.grey.shade100,
                child: Image(
                  image: AssetImage('./././asset/carousal_img_7.jpg'),
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              // Your carousel items
            ],
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              // Carousel options
            ),
          ),
          ListTile(
            title: const Text(
              'Available Restaurants',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: restaurantsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No registered restaurants available'));
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var document = snapshot.data!.docs[index];
                      return RestaurantCard(
                          name: document['name'],
                          address: document['address'],
                        );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String name;
  final String address;


  const RestaurantCard({
    Key? key,
    required this.name,
    required this.address,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3.0,
      child: ListTile(
        leading: CircleAvatar(
        ),
        title: Text(name),
        subtitle: Text(address),
      ),
    );
  }
}
