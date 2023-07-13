import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserImagesUploadService {
  static Future<dynamic> uploadFile(
      List<XFile> filePaths, XFile pickedFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List images = [];
      if (pickedFile != null) {
        var image = await MultipartFile.fromFile(pickedFile.path,
            filename: "/${pickedFile.path}");
        images.add(image);
        print('++++image+++++++++++++++++++++++++++---------');
      } else {
        for (XFile imageFile in filePaths) {
          var image = await MultipartFile.fromFile(imageFile.path,
              filename: "/${imageFile.path}");
          images.add(image);
        }
      }
      FormData formData = new FormData.fromMap({"user[]": images});
      print(PettySharedPref.getUserId(prefs));

      var response =
          await Dio().post("$baseUrlWithHttps/pettyapp/api/add_photo",
              data: formData,
              queryParameters: {
                'user_id': PettySharedPref.getUserId(prefs),
                'token': PettySharedPref.getAccessToken(prefs)
              },
              options: Options(headers: <String, String>{
                'Authorization':
                    'ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2',
              }));
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }
}
