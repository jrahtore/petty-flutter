import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuperPettyActivateApi {
  Future<dynamic> superPettyActivate(String likeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final queryParameters = {
      'user_id': _userId,
      'token': _token,
      'superpetty_like_id': likeId,
    };
    var url = Uri.https(baseUrl, '/pettyapp/api/superpetty', queryParameters);

    final response = await http.post(url, headers: {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
