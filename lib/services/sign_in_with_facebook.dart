import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:intl/intl.dart';
import 'package:petty_app/models/facebook_model.dart';

class SignInWithFacebook {
  Future<FacebookModel> signIn() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile', 'user_birthday', 'user_gender'],
    ); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final userData = await FacebookAuth.i.getUserData(
        fields: "name,email,picture.width(200),birthday,gender",
      ); // name, phone/email, age, gender -> Agree page
      // , photo, category, subcategory
      FacebookModel facebookModel = FacebookModel.fromJson(userData);
      // final AccessToken accessToken = result.accessToken;
      return facebookModel;
    } else {
      return null;
      print(result.status);
      print(result.message);
    }
  }

  Future<bool> checkUserAlreadySignedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;
// or FacebookAuth.i.accessToken
    if (accessToken != null) {
      return true;
    }
    return false;
  }

  Future<bool> logoutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  int ageFromDateOfBirth(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;

    return yearDiff;
  }
}
