class DeleteResponseModel {
  final String status;
  final String message;
  DeleteResponseModel({this.status, this.message});
  factory DeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class DeleteRequestModel {
  String userId;
  String token;
  DeleteRequestModel({this.userId, this.token});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': userId.trim(),
      'token': token.trim(),
    };
    return map;
  }
}
