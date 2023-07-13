class SettingsUpdateResponseModel {
  final String status;
  final String message;

  SettingsUpdateResponseModel({this.status, this.message});
  factory SettingsUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return SettingsUpdateResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class SettingsUpdateRequestModel {
  String type;
  String userId;
  String token;
  String btnStatus;
  SettingsUpdateRequestModel(
      {this.btnStatus, this.token, this.userId, this.type});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId.trim(),
      'status': btnStatus.trim(),
      'token': token.trim(),
      'type': type.trim(),
    };

    return map;
  }
}
