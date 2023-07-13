import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/sticker_details_model.dart';
import 'package:petty_app/utils/urls.dart';

import '../models/stickers_model.dart';

class StickersApi {
  final headers = {
    "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
  };
  Future<StickersModel> stickersGet() async {
    var url = Uri.https(baseUrl, '/pettyapp/api/stickers_category');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return StickersModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }

  Future<StickerDetailsModel> stickerDetailsGet(String categoryId) async {
    final queryParameters = {'category_id': categoryId};
    var url = Uri.https(baseUrl, '/pettyapp/api/stickers', queryParameters);
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return StickerDetailsModel.fromJson(
        json.decode(response.body),
      );
    } else {
      return null;
    }
  }
}
