import 'package:flutter/material.dart';
import 'package:petty_app/screens/authentication/authenticate.dart';
import 'package:petty_app/services/firebase_auth.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/splashscreen.dart';
import '../services/online_status.dart';

class LogoutAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  LogoutAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 5.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius),
      ),
      actions: <Widget>[
        negativeBtnText != null
            ? TextButton(
                child: Text(
                  negativeBtnText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNegativePressed != null) {
                    onNegativePressed();
                  }
                },
              )
            : null,
        positiveBtnText != null
            ? TextButton(
                child: Text(
                  positiveBtnText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // textColor: Color(pinkColor),
                onPressed: () async {
                  /*Navigator.of(context).pop();
            if (onPostivePressed != null) {
              onPostivePressed();
            }*/

                  //Navigator.pop(context);
                  await UpdateOnlineOffline().updateIAmOffline();
                  await FirebaseAuthService().FirebaseLogout();
                  logoutClearPreferences();
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                      (Route) => false);
                },
              )
            : null,
      ],
    );
  }

  logoutClearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
