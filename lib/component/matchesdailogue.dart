import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/screens/go_premium_pkgs.dart';
import 'package:petty_app/utils/constant.dart';

// import 'package:flutter_svg/svg.dart';

class DriveDialogBox extends StatefulWidget {
  @override
  _DriveDialogBoxState createState() => _DriveDialogBoxState();
}

class _DriveDialogBoxState extends State<DriveDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding,
              right: Constants.padding,
              bottom: 20),
          margin:
              EdgeInsets.only(top: Constants.avatarRadius, left: 5, right: 5),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Image.asset(
                      "assets/images/crossback.png",
                      scale: 1.3,
                    ),
                    padding: EdgeInsets.all(6),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/gopremiumtorranceimage.png",
                scale: 2,
              ),
              Text(
                "Go Premium!",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SFUIDisplay",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "To View and Share Stories with Matched Profiles.\nWe PETTY good things are not free ;)",
                style: TextStyle(
                  color: Color(0xff7B7B7C),
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoPremiumPkgs(),
                      ));
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(pinkColor),
                          Color(0xffFF5F5D),
                        ],

                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        //transform: GradientRotation(0.7853982),
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      "Get Premium",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SFUIDisplay",
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => SettingPage(),
                  //     ));
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xff7B7B7C),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      "No Thanks",
                      style: TextStyle(
                        color: Color(0xff7B7B7C),
                        fontFamily: "SFUIDisplay",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();

  static const double padding = 10;
  static const double avatarRadius = 30;
}
