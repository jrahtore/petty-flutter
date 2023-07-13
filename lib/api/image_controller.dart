import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/user_images_upload_api.dart';

import 'image_upload_api.dart';

class ImageController extends GetxController {
  var isLoading = false.obs;

  Future<String> uploadImage(
      ImageSource imageSource, bool isFromAddProfileImage,
      {bool isMultiple = false}) async {
    try {
      List<XFile> pickedFiles;
      XFile pickedFile;
      if (isMultiple) {
        pickedFiles = await ImagePicker().pickMultiImage();
      } else {
        pickedFile = await ImagePicker().pickImage(source: imageSource);
      }

      isLoading(true);
      if (pickedFiles != null && pickedFiles.isNotEmpty || pickedFile != null) {
        var response;
        if (isFromAddProfileImage) {
          response = await ImageService.uploadFile(pickedFile.path);
        } else {
          response =
              await UserImagesUploadService.uploadFile(pickedFiles, pickedFile);
        }

        print('++response++');
        if (response.statusCode == 200) {
          //get image url from api response

          // Get.snackbar('Success', 'Image uploaded successfully',
          //     margin: EdgeInsets.only(top: 5, left: 10, right: 10));
          // print('image upload response = $response');
          if (pickedFiles != null && pickedFiles.isNotEmpty) {
            return pickedFiles[0].path;
          } else {
            return pickedFile.path;
          }
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
