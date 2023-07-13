import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petty_app/screens/root_class.dart';
import 'package:petty_app/services/location_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Timer timer;

  @override
  void initState() {
    print("splash calling");
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _controller.repeat(reverse: true);
    getLocationService();
  }

  getLocationService() async {
    try {
      LocationService locationService = LocationService();
      bool isLocationServiceEnabled =
          await locationService.requestLocationPermission();
      if (isLocationServiceEnabled) {
        initTimer(true);
        locationService.storeCurrentLocation();
      } else {
        initTimer(false);
      }
    } catch (e) {
      print('Location services not available');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff043d8b),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              child: ScaleTransition(
                scale: Tween(begin: 0.75, end: 2.0).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.elasticOut)),
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/splashpetty.svg',
                    width: 150,
                    height: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              child: ScaleTransition(
                scale: Tween(begin: 0.55, end: 2.0).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.elasticOut)),
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/dontdate.svg',
                    width: 50,
                    height: 3.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initTimer(bool isLocationEnabled) {
    timer = Timer(Duration(seconds: 5), () {
      isLocationEnabled
          ? Root().initialSetup(context)
          : Root().cannotContinueSetup(context);
    });
  }
}
