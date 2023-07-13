import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/chat_background_model.dart';
import 'package:petty_app/utils/urls.dart';

class ChatBackgroundApi {
  Future<ChatBackgroundModel> chatBackgroundGet() async {
    var url = Uri.https(baseUrl, '/pettyapp/api/design');
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ChatBackgroundModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
}
