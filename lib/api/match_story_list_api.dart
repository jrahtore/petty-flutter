import 'package:dio/dio.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'match_story_list.dart';

class MatchStoryListApiService {
  String _url = "$baseUrlWithHttps/pettyapp/api/get_stories";

  Dio _dio;

  MatchStoryListApiService() {
    _dio = Dio();
  }

  Future<List<StoryContent>> fetchMatchStory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.get(_url,
          queryParameters: {
            'id': PettySharedPref.getUserId(prefs),
            'token': PettySharedPref.getAccessToken(prefs),
            'type': 'matchstory'
          },
          options: Options(headers: {
            "Authorization":
                "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
          }));
      MatchStoryList matchStoryList = MatchStoryList();
      matchStoryList.getMatchList(response.data);
      if (response.statusCode == 200 && matchStoryList.status == 'success') {
        print(matchStoryList.storyList.toString());
        return matchStoryList.storyList;
      }
      return [];
    } catch (e) {
      print(e);
    }
  }
}
