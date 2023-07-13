import 'dart:core';

class RegisterResponseModel {
  final String status;
  final String message;
  final Data data;
  RegisterResponseModel({this.status, this.message, this.data});
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
      data: json["data"] != null
          ? new Data.fromJson(json['data'])
          : new Data(userId: -1),
    );
  }
}

class RegisterRequestModel {
  String name;
  String phone;
  String countrycode;
  String location;
  String age;
  String gender;
  String longitude;
  String latitude;
  String occupation;
  String about;
  String hobbies;
  RegisterRequestModel({
    this.name,
    this.age,
    this.countrycode,
    this.location,
    this.gender,
    this.longitude,
    this.latitude,
    this.phone,
    this.occupation,
    this.about,
    this.hobbies,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name.trim(),
      'age': age,
      'country_code': countrycode,
      'location': location?.trim(),
      'gender': gender.trim(),
      'longitude': longitude?.trim(),
      'latitude': latitude?.trim(),
      'phone': phone.trim(),
      'occupation': occupation.trim(),
      'about': about.trim(),
      'hobbies': hobbies.trim(),
    };
    return map;
  }
}

class Data {
  int userId;
  String token;

  Data({this.userId, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
