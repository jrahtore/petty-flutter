import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/settings_update_model.dart';
import 'package:petty_app/utils/urls.dart';

class SettingsUpdateApi {
  Future<SettingsUpdateResponseModel> settingsUpdate(
      SettingsUpdateRequestModel settingsUpdateRequestModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/settings',
    );

    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: settingsUpdateRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SettingsUpdateResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
