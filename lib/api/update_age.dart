import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/urls.dart';

class UpdateAgeService {
  static Future<dynamic> updateAge(String age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response =
          await Dio().post("$baseUrlWithHttps/pettyapp/api/update_profile",
              queryParameters: {
                'type': 'age',
                'age': age,
                'id': PettySharedPref.getUserId(prefs),
                'token': PettySharedPref.getAccessToken(prefs)
              },
              options: Options(headers: <String, String>{
                'Authorization':
                    'ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2',
              }));
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }
}
