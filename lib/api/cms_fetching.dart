import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/cms.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CmsFetching {
  Future<CmsResponseModel> cmsGet(CmsRequestModel userRequestModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString("type");
    //int type = 1;
    final queryParameters = {'type': type};
    var url = Uri.https(baseUrl, '/pettyapp/api/cms', queryParameters);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return CmsResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response.statusCode);
      // throw Exception('Failed to load data!');
    }
  }
}
