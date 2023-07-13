import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/match_add_model.dart';
import 'package:petty_app/utils/urls.dart';

class MatchAdd {
  Future<MatchAddResponseModel> matchadd(
      MatchAddRequestModel matchAddRequestModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/match_store_notification',
    );

    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: matchAddRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return MatchAddResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
