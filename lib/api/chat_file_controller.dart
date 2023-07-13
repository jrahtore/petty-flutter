// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:petty_app/models/chat_image_response.dart';

import 'chat_image_upload_api.dart';

class ChatFileController extends GetxController {
  var isLoading = false.obs;
  Future<String> uploadImage(
      CollectionReference collectionReference, String UID) async {
    String url = '';
    try {
      final pickedFile = await FilePicker.platform.pickFiles();
      isLoading(true);

      if (pickedFile != null) {
        var result = await ChatImageUploadService.uploadFile(
            pickedFile.files.single.path);
        if (result.statusCode == 200) {
          url = ChatImageResponse.fromJson(result.data).data.url;
          collectionReference.add({
            'user': UID,
            'time': FieldValue.serverTimestamp(),
            'file': url,
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
