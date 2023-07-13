import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petty_app/models/user_category_model.dart' as category;
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserCategory {
  Future<List<String>> userCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    String _token = PettySharedPref.getAccessToken(prefs);
    final queryParameters = {'id': _userId, 'token': _token};
    var url =
        Uri.https(baseUrl, '/pettyapp/api/user_category', queryParameters);
    final headers = {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      category.UserCategoryModel model =   category.UserCategoryModel.fromJson(json.decode(response.body));
      List<String> categoryList = [];
      for (category.Data data in model.data) {
        if (!categoryList.contains(data.categoryName))
          categoryList.add(data.categoryName);
          print("catgory list  ${categoryList}");
      }
      return categoryList;
    } else {
      return [];
    }
  }
}
