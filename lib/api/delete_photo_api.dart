
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petty_app/models/delete_photo_model.dart';
import 'package:petty_app/utils/urls.dart';

class DeletePhotoApi {
  Future<DeletePhotoResponseModel> deletePhoto(
      DeletePhotoRequestModel deletePhotoRequestModel) async {
    var url = Uri.https(
      baseUrl,
      '/pettyapp/api/delete_photo',
    );

    final response = await http.delete(url,
        headers: {
          "Authorization":
          "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
        },
        body: deletePhotoRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return DeletePhotoResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
