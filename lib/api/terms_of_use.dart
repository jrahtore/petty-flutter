import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cms.dart';
import '../screens/setting/cms_screen.dart';
import 'cms_fetching.dart';

String content = "";
String caption = "";

class TermsOfUseApiCall {
  void apiCall(BuildContext context, {String type = '1'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", type);
    CmsRequestModel cmsRequestModel = CmsRequestModel(type: type);
    //cmsRequestModel.type = type;
    CmsFetching cmsFetching = new CmsFetching();
    cmsFetching.cmsGet(cmsRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          print(value.message);
          content = value.data.content;
          caption = value.data.caption;

          // final snackBar = SnackBar(
          //     content: Text(value.message),
          //     duration: const Duration(seconds: 1));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CmsScreen(
                    type: type,
                    content: content,
                    caption: caption,
                  )));
        } else {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }
}
