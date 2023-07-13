import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:petty_app/screens/splashscreen.dart';

class NoLocationEnabledScreen extends StatelessWidget {
  const NoLocationEnabledScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_outlined,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Location permissions denied!',
              style: TextStyle(
                  color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Grand location permissions and restart the app to continue',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width / 1.2,
              height: 50,
              child: ElevatedButton(
                onPressed: () async => Geolocator.openLocationSettings(),
                child: Text(
                  'Grand Permission',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width / 1.2,
              height: 50,
              child: ElevatedButton(
                onPressed: () async => Get.offAll(SplashScreen()),
                child: Text(
                  'Restart',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
