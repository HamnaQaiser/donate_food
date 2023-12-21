
class LocationManager{

  static final LocationManager _location = LocationManager._internal();

  String? local;

  factory LocationManager(){
    return _location;
  }

  LocationManager._internal();

}