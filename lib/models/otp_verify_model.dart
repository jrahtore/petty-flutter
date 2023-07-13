class VerifyResponseModel {
  final String status;
  final String message;
  final Data data;
  VerifyResponseModel({this.status, this.message, this.data});
  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
      data: json["data"] != null
          ? new Data.fromJson(json['data'])
          : new Data(userId: "-1"),
    );
  }
}

class VerifyRequestModel {
  String phone;
  String countrycode;
  String userId;
  String otp;
  VerifyRequestModel({this.phone, this.countrycode, this.userId, this.otp});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'phone': phone.trim(),
      'country_code': countrycode.trim(),
      'user_id': userId.trim(),
      'otp': otp.trim(),
    };
    return map;
  }
}

class Data {
  String userId;
  String token;
  bool photo_uploaded;
  bool category_choosen;
  bool subcategory_choosen;

  Data(
      {this.userId,
      this.token,
      this.category_choosen,
      this.photo_uploaded,
      this.subcategory_choosen});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    photo_uploaded = json['photo_uploaded'];
    category_choosen = json['category_choosen'];
    subcategory_choosen = json['subcategory_choosen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['photo_uploaded'] = this.photo_uploaded;
    data['category_choosen'] = this.category_choosen;
    data['subcategory_choosen'] = this.subcategory_choosen;
    return data;
  }
}
