import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';
import 'authentication/authenticate.dart';
import 'main_bottom_page.dart';
import 'no_location_enabled_screen.dart';

class Root {
  bool isLoggedIn = false;
  initialSetup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (PettySharedPref.getIsLoggedIn(prefs) != null &&
        PettySharedPref.getIsLoggedIn(prefs)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            print('mainbottomhome from root');
            return MainBottomPage();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            // return Category();
            return Authenticate();
          },
        ),
      );
    }
  }

  cannotContinueSetup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NoLocationEnabledScreen();
        },
      ),
    );
  }
}
