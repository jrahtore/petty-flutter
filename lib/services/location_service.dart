import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Enable location services',
          'Location services are required to continue',
          snackPosition: SnackPosition.TOP);
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Grand location permission',
            'Location permissions are mandatory to continue',
            snackPosition: SnackPosition.TOP);
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Grand location permission',
              'Location permission are required to show relevant profiles',
              snackPosition: SnackPosition.TOP);
          return false;
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.snackbar('Grand location permission',
          'Location services should be enabled to continue',
          snackPosition: SnackPosition.TOP);
      return false;
    }

    return true;
  }

  Future<void> storeCurrentLocation() async {
    bool isServiceEnabled = await requestLocationPermission();
    if (isServiceEnabled) {
      Position position = await _getGeoLocationPosition();
      String address = await _getAddressFromLatLong(position);
      _saveLocationData(position, address);
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> _getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return "${place.locality}, ${place.country}";
  }

  void _saveLocationData(Position position, String address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    PettySharedPref.setLat(pref, position.latitude);
    PettySharedPref.setLon(pref, position.longitude);
    PettySharedPref.setLocation(pref, address);
  }
}
