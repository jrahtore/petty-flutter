import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget {
  final String text;
  Loading(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF8FBFF),
                Color(0xFFDCE0E4),
                Color(0xFFC0C2C4),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitChasingDots(
                color: Color(0xFFA2C30F),
                size: 50.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),),
    );
  }
}
