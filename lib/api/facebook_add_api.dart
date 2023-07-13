import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/utils/urls.dart';

import '../models/facebook_model.dart';

class FacebookAdd {
  Future<bool> facebookAdd(FacebookModel facebookModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/facebook',
    );

    Map map = {
      'name': facebookModel.name,
      'birthday': facebookModel.birthday,
      'photo': facebookModel.picture.data.url,
      'email': facebookModel.email,
      'gender': facebookModel.gender
    };

    final response = await http.post(url,
        headers: {
          "Authorization":
              "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: map);

    print('photo link =${facebookModel.picture.data.url}');
    if (response.statusCode == 200 || response.statusCode == 400) {
      return json.decode(response.body)['status'] == 'success';
    } else {
      return false;
    }
  }
}
