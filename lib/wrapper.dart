// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/screens/authentication/authenticate.dart';
import 'package:petty_app/screens/main_bottom_page.dart';
import 'package:petty_app/screens/welcome_page.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  static var routeName = '/wrapper';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    if (user == null) {
      print("User is null");
      return Authenticate();
    } else {
      print("User is not null and Logged In");
      return StreamBuilder<UserData>(
        //stream: DatabaseService(uid: user.uid).uData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot data ==============");
            if (snapshot.data.firstLogIn) {
              print('welcomepage from wrapper');
              return WelcomePage();
            } else {
              print('category from wrapper');
              return MainBottomPage();

            }
          } else {
            return buildProgressBar();
          }
        },
      );
    }
  }
}
// else {
//   print("User is not null and Logged In ${user.uid}");
//   return MainBottomPage();
// }
//  }
//  }
