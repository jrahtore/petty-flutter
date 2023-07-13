class DeletePhotoResponseModel {
  final String status;
  final String message;

  DeletePhotoResponseModel({this.status, this.message});
  factory DeletePhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return DeletePhotoResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class DeletePhotoRequestModel {
  String photoId;
  String userId;
  String token;
  DeletePhotoRequestModel({this.photoId, this.token, this.userId});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId.trim(),
      'photo_id': photoId.trim(),
      'token': token.trim(),
    };

    return map;
  }
}
