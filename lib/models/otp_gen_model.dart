class OtpResponseModel {
  final String status;
  final String message;
  final Data data;
  //final Data data;
  OtpResponseModel({this.status, this.message, this.data});
  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
      //data: json["data"] != null ? json["data"] : "",
      data: json["data"] != null
          ? new Data.fromJson(json['data'])
          : new Data(userId: "-1"),
    );
  }
}

class OtpRequestModel {
  String phone;
  String countrycode;
  OtpRequestModel({this.phone, this.countrycode});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'phone': phone,
      'country_code': countrycode ?? '+93',
    };
    return map;
  }
}

class Data {
  String userId;

  Data({this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    return data;
  }
}
