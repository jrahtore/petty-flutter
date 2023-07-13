import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/api/my_profile/my_profile_response.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile {
  Future<MyProfileResponse> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final queryParameters = {'id': _userId, 'token': _token};
    var url = Uri.https(baseUrl, '/pettyapp/api/get_profile', queryParameters);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return MyProfileResponse.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
