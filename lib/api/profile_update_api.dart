import 'dart:convert';

import 'package:petty_app/models/profile_update_model.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateApi {
  Future<ProfileUpdateResponseModel> updateProfile(
      ProfileUpdateRequestModel profileUpdateRequestModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/update_profile',
    );

    final response = await http.post(url,
        headers: {
          "Authorization":
          "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: profileUpdateRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ProfileUpdateResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}