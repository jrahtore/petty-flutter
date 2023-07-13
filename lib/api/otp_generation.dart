import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/otp_gen_model.dart';
import 'package:petty_app/utils/urls.dart';

class OtpGeneration {
  Future<OtpResponseModel> otpgen(OtpRequestModel otpRequestModel) async {
    // var url = Uri.https(
    //   'petty.sample.tk',
    //   '/pettyapp/api/otp_generation',
    // );

    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/otp_generation',
    );

    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: otpRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return OtpResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      print(response.body);
      throw Exception('Failed to load data!');
    }
  }
}
