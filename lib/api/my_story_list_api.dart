import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStoryListApiService {
  Future<Map> fetchMyStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };
    final queryParameters = {'id': _userId, 'token': _token, 'type': 'mystory'};
    var url = Uri.https(baseUrl, '/pettyapp/api/get_stories', queryParameters);

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body) as Map;
      return map;
      // return users;
    } else {
      return null;
    }
  }
}
