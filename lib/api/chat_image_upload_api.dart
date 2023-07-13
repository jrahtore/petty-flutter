import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/urls.dart';

class ChatImageUploadService {
  static Future<dynamic> uploadFile(filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData formData = new FormData.fromMap({
        "resource":
            await MultipartFile.fromFile(filePath, filename: "/$filePath")
      });

      final response = await Dio()
          .post("$baseUrlWithHttps/pettyapp/api/chat_store",
              data: formData,
              queryParameters: {
                'user_id': PettySharedPref.getUserId(prefs),
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
