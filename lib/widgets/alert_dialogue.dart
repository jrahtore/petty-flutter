import 'package:flutter/material.dart';

import 'alert_box_textbutton.dart';

//
void showAlertDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final Size screenSize = MediaQuery.of(context).size;
      return AlertDialog(
        insetPadding: EdgeInsets.only(left: 15, right: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        content: Container(
          width: screenSize.width,
          height: screenSize.height - 320,
          child: Column(
            children: [
              Text(
                'Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffe4547f),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Please Select The Reason',
                style: TextStyle(
                  color: Color(0xffe4547f),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/smilie.png',
                txt: 'I Am Not Interested In This Person',
                // icon: Icons.face,
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/fake-profile.png',
                txt: 'Fake Profile/Spam',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/messages.png',
                txt: 'Inapropriate Messages',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/camera.png',
                txt: 'Inapropriate Photos',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/inapropiate-bio.png',
                txt: 'Inapropriate Bio',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/under-age.png',
                txt: 'Underage User',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/offline-behaviour.png',
                txt: 'Offline Behaviour',
              ),
              AlertBoxTextButton(
                IconImage: 'assets/images/danger.png',
                txt: 'Someone Is In Danger',
              ),
            ],
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
