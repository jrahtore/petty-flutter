import 'package:flutter/material.dart';
import 'package:petty_app/api/delete_account.dart';
import 'package:petty_app/models/deleteaccount.dart';
import 'package:petty_app/screens/splashscreen.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;
  final DeleteRequestModel deleteAccountRequestModel = new DeleteRequestModel(
    userId: "default",
    token: "default",
  );

  DeleteAlertDialog({
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
                  deleteClearPreferences();
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  deleteAccountRequestModel.userId =
                      PettySharedPref.getUserId(preferences);
                  deleteAccountRequestModel.token =
                      PettySharedPref.getAccessToken(preferences);
                  await preferences.clear();

                  //Navigator.pop(context);
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

  void deleteClearPreferences() {
    DeleteAccount deleteAccount = new DeleteAccount();
    deleteAccount.delete(deleteAccountRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          // final snackBar = SnackBar(
          //     content: Text(value.message),
          //     duration: const Duration(seconds: 1));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // final snackBar = SnackBar(
          //     content: Text(value.message),
          //     duration: const Duration(seconds: 1));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      }
    });
  }
}
