// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/models/chat_image_response.dart';

import 'chat_image_upload_api.dart';

class ChatImageController extends GetxController {
  var isLoading = false.obs;

  Future<String> uploadImage(ImageSource imageSource,
      CollectionReference collectionReference, String UID) async {
    String url = '';
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: imageSource,
          maxHeight: 500.0,
          maxWidth: 500.0,
          imageQuality: 80);
      isLoading(true);
      if (pickedFile != null) {
        var result = await ChatImageUploadService.uploadFile(pickedFile.path);
        if (result.statusCode == 200) {
          url = ChatImageResponse.fromJson(result.data).data.url;
          collectionReference.add({
            'user': UID,
            'time': FieldValue.serverTimestamp(),
            'image': url,
          });
        }
        return url;
      }
      return '';
    } finally {
      isLoading(false);
    }
  }

  Future<String> uploadVideo(ImageSource imageSource,
      CollectionReference collectionReference, String UID) async {
    String url = '';
    try {
      final pickedFile = await ImagePicker().pickVideo(
        source: imageSource,
        maxDuration: Duration(minutes: 5),
      );
      isLoading(true);
      if (pickedFile != null) {
        var result = await ChatImageUploadService.uploadFile(pickedFile.path);
        if (result.statusCode == 200) {
          url = ChatImageResponse.fromJson(result.data).data.url;
          collectionReference.add({
            'user': UID,
            'time': FieldValue.serverTimestamp(),
            'video': url,
          });
        }
        return url;
      }
      return '';
    } finally {
      isLoading(false);
    }
  }
}
