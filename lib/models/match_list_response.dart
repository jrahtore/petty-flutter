/// status : "success"
/// message : [{"id":"46","name":"Felista","username":null,"gender":"female","reset_key":"0","country_code":"+91","phone":"9995208963","status":"1","date":"2022-01-06","is_verify":"1","otp":"2922","photo_link":"img3.jpg","token":"QrjPjzhbRvSCxLPkO48d","refresh_token":"n0qxVe0PLPgiJO5","latitude":"9.96441","longitude":"76.2901","occupation":null,"age":"20","image":"https://petty.sample.tk/pettyapp/admin/profile_images/img3.jpg","distance":"20 miles"},{"id":"45","name":"Sajay","username":null,"gender":"female","reset_key":"0","country_code":"+91","phone":"8086144019","status":"1","date":"2022-01-06","is_verify":"1","otp":null,"photo_link":"img5.jpg","token":"FPVMfnlL6DAZ6U3qOW1S","refresh_token":"aB2HiDXVqbMt7tI","latitude":"9.96436","longitude":"76.2901","occupation":null,"age":"22","image":"https://petty.sample.tk/pettyapp/admin/profile_images/img5.jpg","distance":"20 miles"},{"id":"44","name":"Vinu","username":null,"gender":"male","reset_key":"0","country_code":"+91","phone":"8089190079","status":"1","date":"2022-01-06","is_verify":"1","otp":"4896","photo_link":"img2.jpg","token":"4mxOFHZAfLERC5GUS12G","refresh_token":"g4PkuOuz9QerpDl","latitude":"9.12392","longitude":"46.1312","occupation":null,"age":"22","image":"https://petty.sample.tk/pettyapp/admin/profile_images/img2.jpg","distance":"20 miles"},{"id":"43","name":"amal","username":null,"gender":"male","reset_key":"0","country_code":"+91","phone":"7012403673","status":"1","date":"2022-01-06","is_verify":"1","otp":"2691","photo_link":"img4.jpg","token":"G5f60RYckHLUaFzz5zT2","refresh_token":"h9PSmsFpNElJCkD","latitude":"9.12392","longitude":"46.1312","occupation":null,"age":"22","image":"https://petty.sample.tk/pettyapp/admin/profile_images/img4.jpg","distance":"20 miles"},{"id":"42","name":"jan","username":null,"gender":"male","reset_key":"0","country_code":" 91","phone":"8129452213","status":"1","date":"2022-01-06","is_verify":"1","otp":"8938","photo_link":"img6.jpg","token":"ulEmJwf6Wcu6zlgcS8lF","refresh_token":"dCLdBB2fKFt4ZFx","latitude":"3.99999","longitude":"3.7789","occupation":null,"age":"20","image":"https://petty.sample.tk/pettyapp/admin/profile_images/img6.jpg","distance":"20 miles"}]

class MatchListResponse {
  MatchListResponse({
    String status,
    List<Message> message,
  }) {
    _status = status;
    _message = message;
  }

  MatchListResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message.add(Message.fromJson(v));
      });
    }
  }
  String _status;
  List<Message> _message;

  String get status => _status;
  List<Message> get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "46"
/// name : "Felista"
/// username : null
/// gender : "female"
/// reset_key : "0"
/// country_code : "+91"
/// phone : "9995208963"
/// status : "1"
/// date : "2022-01-06"
/// is_verify : "1"
/// otp : "2922"
/// photo_link : "img3.jpg"
/// token : "QrjPjzhbRvSCxLPkO48d"
/// refresh_token : "n0qxVe0PLPgiJO5"
/// latitude : "9.96441"
/// longitude : "76.2901"
/// occupation : null
/// age : "20"
/// image : "https://petty.ample.tk/pettyapp/admin/profile_images/img3.jpg"
/// distance : "20 miles"

class Message {
  Message({
    String id,
    String name,
    dynamic username,
    String gender,
    String resetKey,
    String countryCode,
    String phone,
    String status,
    String date,
    String isVerify,
    String otp,
    String photoLink,
    String token,
    String refreshToken,
    String latitude,
    String longitude,
    dynamic occupation,
    String age,
    String image,
    String distance,
  }) {
    _id = id;
    _name = name;
    _username = username;
    _gender = gender;
    _resetKey = resetKey;
    _countryCode = countryCode;
    _phone = phone;
    _status = status;
    _date = date;
    _isVerify = isVerify;
    _otp = otp;
    _photoLink = photoLink;
    _token = token;
    _refreshToken = refreshToken;
    _latitude = latitude;
    _longitude = longitude;
    _occupation = occupation;
    _age = age;
    _image = image;
    _distance = distance;
  }

  Message.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _gender = json['gender'];
    _resetKey = json['reset_key'];
    _countryCode = json['country_code'];
    _phone = json['phone'];
    _status = json['status'];
    _date = json['date'];
    _isVerify = json['is_verify'];
    _otp = json['otp'];
    _photoLink = json['photo_link'];
    _token = json['token'];
    _refreshToken = json['refresh_token'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _occupation = json['occupation'];
    _age = json['age'];
    _image = json['image'];
    _distance = json['distance'];
  }
  String _id;
  String _name;
  dynamic _username;
  String _gender;
  String _resetKey;
  String _countryCode;
  String _phone;
  String _status;
  String _date;
  String _isVerify;
  String _otp;
  String _photoLink;
  String _token;
  String _refreshToken;
  String _latitude;
  String _longitude;
  dynamic _occupation;
  String _age;
  String _image;
  String _distance;

  String get id => _id;
  String get name => _name;
  dynamic get username => _username;
  String get gender => _gender;
  String get resetKey => _resetKey;
  String get countryCode => _countryCode;
  String get phone => _phone;
  String get status => _status;
  String get date => _date;
  String get isVerify => _isVerify;
  String get otp => _otp;
  String get photoLink => _photoLink;
  String get token => _token;
  String get refreshToken => _refreshToken;
  String get latitude => _latitude;
  String get longitude => _longitude;
  dynamic get occupation => _occupation;
  String get age => _age;
  String get image => _image;
  String get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['gender'] = _gender;
    map['reset_key'] = _resetKey;
    map['country_code'] = _countryCode;
    map['phone'] = _phone;
    map['status'] = _status;
    map['date'] = _date;
    map['is_verify'] = _isVerify;
    map['otp'] = _otp;
    map['photo_link'] = _photoLink;
    map['token'] = _token;
    map['refresh_token'] = _refreshToken;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['occupation'] = _occupation;
    map['age'] = _age;
    map['image'] = _image;
    map['distance'] = _distance;
    return map;
  }
}
