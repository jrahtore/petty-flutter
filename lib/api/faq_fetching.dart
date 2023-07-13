import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/utils/urls.dart';

import 'faq_model.dart';

class FaqFetching {
  Future<FaqModel> Faq() async {
    var url = Uri.https(baseUrl, '/pettyapp/api/faq');
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return FaqModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
