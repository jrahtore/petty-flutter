import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/its_a_match_model.dart';

class ItsAMatchApi {
  String _url = "$baseUrlWithHttps/pettyapp/api/match_like_details";

  Dio _dio;

  ItsAMatchApi() {
    _dio = Dio();
  }

  Future<ItsAMatchModel> getMatchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(_url,
          queryParameters: {
            'user_id': PettySharedPref.getUserId(prefs),
            'token': PettySharedPref.getAccessToken(prefs),
          },
          options: Options(headers: {
            "Authorization":
                "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
          }));
      // print(response.data);
      ItsAMatchModel itsAMatchModel = ItsAMatchModel.fromJson(response.data);

      if (response.statusCode == 200 && itsAMatchModel.status == 'success') {
        return itsAMatchModel;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
