import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/match_add_model.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewindApi {
  Future<MatchAddResponseModel> rewind() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final queryParameters = {'id': _userId, 'token': _token};
    var url =
        Uri.https(baseUrl, '/pettyapp/api/get_rewindstatus', queryParameters);

    final response = await http.get(url, headers: {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return MatchAddResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
