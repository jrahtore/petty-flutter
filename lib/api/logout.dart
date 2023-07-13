import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/logout_model.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';

class LogOut {
  Future<LogOutResponseModel> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    LogOutRequestModel logOutRequestModel =
        LogOutRequestModel(userId: _userId, token: _token);

    print("Userdetails userid: " + _userId);
    final queryParameters = {'id': _userId, 'token': _token};
    var url = Uri.https(baseUrl, '/pettyapp/api/Users', queryParameters);
    final response = await http.put(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: logOutRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      return LogOutResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
}
