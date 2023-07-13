class LogOutResponseModel {
  final String status;
  final String message;
  LogOutResponseModel({this.status, this.message});
  factory LogOutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogOutResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class LogOutRequestModel {
  String userId;
  String token;
  LogOutRequestModel({this.userId, this.token});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': userId.trim(),
      'token': token.trim(),
    };
    return map;
  }
}
