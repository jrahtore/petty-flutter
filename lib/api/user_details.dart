import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/models/user_details_model.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends GetxController {
  final userResponseModel = UserResponseModel().obs;
  Future<UserResponseModel> userDetails(
      UserRequestModel userRequestModel) async {
    // var url = Uri.https(
    //   'petty.sample.tk',
    //   '/pettyapp/api/otp_generation',
    // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    print("USerdetails userid: " + _userId);
    final queryParameters = {'id': _userId, 'token': _token};
    var url = Uri.https(baseUrl, '/pettyapp/api/get_profile', queryParameters);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      userResponseModel.value = UserResponseModel.fromJson(
        json.decode(response.body),
      );
      return userResponseModel.value;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
