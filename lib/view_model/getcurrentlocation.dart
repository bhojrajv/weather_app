import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationSingleton{
  static LocationSingleton ?_instance;
  LocationSingleton._();

  static LocationSingleton getinstance(){
    if(_instance==null){
      _instance=LocationSingleton._();
    }
    return _instance??LocationSingleton._();
  }

  static Future<Position> determinePosition() async {
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
        // Permissions are denied, next time you could try
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  static Future<List<Placemark>>getCurrentplace({double? lat,double? long})async{
  List<Placemark>placemars=await placemarkFromCoordinates(lat??52.2165157, long??6.9437819);
  return placemars;
  }
}