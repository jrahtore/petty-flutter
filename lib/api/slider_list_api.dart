import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/models/slider_list_response.dart';
import 'package:petty_app/screens/splashscreen.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase_auth.dart';
import '../services/online_status.dart';
import '../utils/urls.dart';

class SliderApiProvider {
  Future<List<SliderListResponse>> getSlider(int pageNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };
    final queryParameters = {
      'id': _userId,
      'token': _token,
      'page_number': pageNumber
    }.map((key, value) => MapEntry(key, value.toString()));
    var url = Uri.https(baseUrl, '/pettyapp/api/PettyPass', queryParameters);

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print("response successfull");
      print(response.body);
      final users = <SliderListResponse>[];

      var parsedResults;

      if (response.body.isNotEmpty) {
        print("non empty");
        parsedResults = jsonDecode(response.body);
      }

      print("parset result");

      log(parsedResults.toString());

      parsedResults["message"] == 'token expired'
          ? logout()
          : (parsedResults["data"] as List)?.forEach((parsedJson) {
              users.add(
                SliderListResponse.fromJson(parsedJson),
              );
            });

      return users;
    } else {
      return [];
    }
  }

  Future<void> logout() async {
    await UpdateOnlineOffline().updateIAmOffline();
    await FirebaseAuthService().FirebaseLogout();
    logoutClearPreferences();
    Get.offAll(SplashScreen());
  }

  logoutClearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
