import 'package:dio/dio.dart';
import 'package:petty_app/models/match_list_response.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/urls.dart';

class MatchListApiService {
  String _url = "$baseUrlWithHttps/pettyapp/api/match_store_notification";

  Dio _dio;

  MatchListApiService() {
    _dio = Dio();
  }

  Future<List<Message>> fetchMatchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(_url,
          queryParameters: {
            'user_id': PettySharedPref.getUserId(prefs),
            'token': PettySharedPref.getAccessToken(prefs)
          },
          options: Options(headers: {
            "Authorization":
                "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
          }));
      MatchListResponse matchResponse =
          MatchListResponse.fromJson(response.data);

      return matchResponse.message;
    } catch (e) {
      print(e);
    }
  }
}
