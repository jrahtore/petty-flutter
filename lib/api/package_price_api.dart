import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/utils/urls.dart';

import '../component/pack_details.dart';

class PackagePriceApi {
  Future packagePriceGet() async {
    var url = Uri.https(baseUrl, '/pettyapp/api/get_packages');
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      json.decode(response.body)['data'] != null
          ? PackList.packlist = json.decode(response.body)['data']
          : PackList.packlist = [];
    }
  }
}
