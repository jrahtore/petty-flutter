import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/match_add_model.dart';

class ReportUserApi {
  String _url = "$baseUrlWithHttps/pettyapp/api/report_user";

  Dio _dio;

  ReportUserApi() {
    _dio = Dio();
  }

  Future<bool> postReport(String reportUserId, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.post(_url,
          queryParameters: {
            'user_id': PettySharedPref.getUserId(prefs),
            'token': PettySharedPref.getAccessToken(prefs),
            'report_userid': reportUserId,
            'message': message
          },
          options: Options(headers: {
            "Authorization":
                "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
          }));
      // print(response.data);
      MatchAddResponseModel matchAddResponseModel =
          MatchAddResponseModel.fromJson(response.data);

      if (response.statusCode == 200 &&
          matchAddResponseModel.status == 'success') {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
