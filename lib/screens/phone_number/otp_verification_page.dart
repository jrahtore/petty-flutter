import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main_bottom_page.dart';

class OtpVerified extends StatefulWidget {
  @override
  _OtpVerifiedState createState() => _OtpVerifiedState();
}

class _OtpVerifiedState extends State<OtpVerified>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _controller.repeat(reverse: true);
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainBottomPage(),
              // MainBottomPage(),
              //Wrapper(),
              //welcomepage
            )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void hideOpenDialog() {
  //   Navigator.of(context).pop();
  // }

  // void showOtpVerified() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       barrierColor: Colors.white,
  //       builder: (BuildContext context) {
  //         return WillPopScope(
  //           onWillPop: () async => false,
  //           child: AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(8.0))),
  //             backgroundColor: Colors.white,
  //             content: OTPVerified(),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Align(
            child: ScaleTransition(
              scale: Tween(begin: 0.6, end: 0.7).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
              child: SizedBox(
                child: Text(
                  "OTP Verified.",
                  style: TextStyle(fontSize: 50),
                ),
                height: 100,
                width: 500,
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Align(
            child: ScaleTransition(
              scale: Tween(begin: 0.6, end: 0.7).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
              child: SizedBox(
                child: SvgPicture.asset('assets/images/otp_verified.svg'),
                height: 100,
                width: 100,
              ),
            ),
          )
        ]));
  }
}
