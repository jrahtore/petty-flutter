class ProfileUpdateResponseModel {
  final String status;
  final String message;

  ProfileUpdateResponseModel({this.status, this.message});
  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class ProfileUpdateRequestModel {
  String type;
  String userId;
  String token;
  String name;
  String occupation;
  String biodata;
  ProfileUpdateRequestModel(
      {this.type,
      this.token,
      this.userId,
      this.biodata,
      this.occupation,
      this.name});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': userId.trim(),
      'type': type.trim(),
      'token': token.trim(),
      'name': name.trim(),
      'occupation': occupation.trim(),
      'biodata': biodata.trim(),
    };

    return map;
  }
}
