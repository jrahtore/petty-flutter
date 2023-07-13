import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/profile_pic_api.dart';

class ProfilePicController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';

  Future<String> uploadProfileImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      isLoading(true);
      if (pickedFile != null) {
        var response =
            await ProfilePictureService.uploadProfilePic(pickedFile.path);

        if (response.statusCode == 200) {
          //get image url from api response
          imageURL = response.data['data'];
          return imageURL;
        } else if (response.statusCode == 401) {
          Get.offAllNamed('/sign_up');
          return '';
        } else {
          Get.snackbar('Failed', 'Error Code: ${response.statusCode}',
              margin: EdgeInsets.only(top: 5, left: 10, right: 10));
          return '';
        }
      } else {
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        return '';
      }
    } finally {
      isLoading(false);
    }
  }
}
