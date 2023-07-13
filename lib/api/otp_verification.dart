import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/otp_verify_model.dart';
import 'package:petty_app/utils/urls.dart';

class OtpVerification {
  Future<VerifyResponseModel> otpver(
      VerifyRequestModel verifyRequestModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/otp_verification',
    );
    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: verifyRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return VerifyResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
}
