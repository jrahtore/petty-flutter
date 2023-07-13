

import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/urls.dart';

class ProfilePictureService{
  static Future<dynamic> uploadProfilePic(filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData formData =
      new FormData.fromMap({
        "pro_pic":
        await MultipartFile.fromFile(filePath, filename: "/$filePath")});

      Response response =
      await Dio().post(
          "$baseUrlWithHttps/pettyapp/api/update_profile",
          data: formData,
          queryParameters: {'id': PettySharedPref.getUserId(prefs), 'token': PettySharedPref.getAccessToken(prefs),'type':'profilepic'},
          options: Options(
              headers: <String, String>{
                'Authorization': 'ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2',
              }
          )
      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}