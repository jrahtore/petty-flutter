import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/register_model.dart';
import 'package:petty_app/utils/urls.dart';

class Registration {
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    var url =  Uri.https(
      baseUrl,
      '/pettyapp/api/registration',
    );
    print('//registration\n*****');
    print(url);
    print(requestModel.latitude);
    print(requestModel.longitude);
    print(requestModel.location);
    if (requestModel.latitude == null) {
      requestModel.latitude = '0';
    }
    if (requestModel.longitude == null) {
      requestModel.longitude = '0';
    }

    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      print('*****\n//registration');
      return RegisterResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response.statusCode.toString()+"printing code");
      throw Exception('Failed to load data!');
    }
  }
}
