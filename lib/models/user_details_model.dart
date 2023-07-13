class UserResponseModel {
  final String status;
  final String message;
  final Data data;
  //final Data data;
  UserResponseModel({this.status, this.message, this.data});
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
      //data: json["data"] != null ? json["data"] : "",
      data: json["data"] != null
          ? new Data.fromJson(json['data'])
          : new Data(
              userId: "-1",
              name: "default",
              countrycode: "+91",
              phone: "1234567890",
              location: "default",
              image: "null",
              gender: "no gender",
              age: "0",
              verify: "1",
              occupation: "job",
              biodata: "Mybio"),
    );
  }
}

class UserRequestModel {
  String id;
  String token;
  UserRequestModel({this.id, this.token});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id.trim(),
      'token': token.trim(),
    };
    return map;
  }
}

class Data {
  String userId;
  String name;
  String age;
  String gender;
  String countrycode;
  String phone;
  String location;
  String verify;
  String image;
  String occupation;
  String biodata;
  String superPettyStatus;

  Data(
      {this.userId,
      this.name,
      this.age,
      this.gender,
      this.countrycode,
      this.phone,
      this.location,
      this.verify,
      this.image,
      this.occupation,
      this.biodata,
      this.superPettyStatus});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    countrycode = json['country_code'];
    phone = json['phone'];
    location = json['location'];
    verify = json['is_verify'];
    image = json['image'];
    occupation = json['occupation'];
    biodata = json['biodata'];
    superPettyStatus = json['superpetty_sts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['country_code'] = this.countrycode;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['is_verify'] = this.verify;
    data['image'] = this.image;
    data['occupation'] = this.occupation;
    data['biodata'] = this.biodata;

    return data;
  }
}
