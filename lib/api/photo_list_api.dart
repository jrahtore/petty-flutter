import 'package:dio/dio.dart';
import 'package:petty_app/models/image_list_response.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/urls.dart';

class PhotoListApiService {
  String _url = "$baseUrlWithHttps/pettyapp/api/view_photos";

  Dio _dio;

  PhotoListApiService() {
    _dio = Dio();
  }

  Future<List<ImageData>> fetchPhotoList({int pageNumber = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(_url,
              queryParameters: {
                'user_id': PettySharedPref.getUserId(prefs),
                'token': PettySharedPref.getAccessToken(prefs),
                'page_number': pageNumber
              },
              options: Options(headers: {
                "Authorization":
                    "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
              }))
          //     .then((value) {
          //   print('imageListResponse = $value');
          //   return null;
          // })
          ;
      ImageListResponse imageListResponse =
          await ImageListResponse.fromJson(response.data);

      return imageListResponse.data;
    } catch (e) {
      print(e);
    }
  }
}
