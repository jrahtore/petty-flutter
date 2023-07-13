/// status : "success"
/// message : "Details found"
/// data : {"id":"45","name":"Sajay S","username":null,"gender":"female","reset_key":"0","country_code":"+91","phone":"8086144019","status":"1","date":"2022-01-06","is_verify":"1","otp":"6166","photo_link":"image_picker5653648535713138679.jpg","token":"4QLErCPepJKNeetMTciK","refresh_token":"aB2HiDXVqbMt7tI","latitude":"37.4219","longitude":"-122.084","occupation":"IT","age":"22","biodata":"I love cheese","location":"Mountain View, United States","slider_status":"0","match_status":"0","superpetty_sts":"1","sound_sts":"0","fcm_key":"","msg_status":"0","image":"https://petty.sample.tk/pettyapp/admin/profile_images/image_picker5653648535713138679.jpg"}

class MyProfileResponse {
  MyProfileResponse({
      String status, 
      String message,
    MyProfileData data,}){
    _status = status;
    _message = message;
    _data = data;
}

  MyProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? MyProfileData.fromJson(json['data']) : null;
  }
  String _status;
  String _message;
  MyProfileData _data;

  String get status => _status;
  String get message => _message;
  MyProfileData get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// id : "45"
/// name : "Sajay S"
/// username : null
/// gender : "female"
/// reset_key : "0"
/// country_code : "+91"
/// phone : "8086144019"
/// status : "1"
/// date : "2022-01-06"
/// is_verify : "1"
/// otp : "6166"
/// photo_link : "image_picker5653648535713138679.jpg"
/// token : "4QLErCPepJKNeetMTciK"
/// refresh_token : "aB2HiDXVqbMt7tI"
/// latitude : "37.4219"
/// longitude : "-122.084"
/// occupation : "IT"
/// age : "22"
/// biodata : "I love cheese"
/// location : "Mountain View, United States"
/// slider_status : "0"
/// match_status : "0"
/// superpetty_sts : "1"
/// sound_sts : "0"
/// fcm_key : ""
/// msg_status : "0"
/// image : "https://petty.sample.tk/pettyapp/admin/profile_images/image_picker5653648535713138679.jpg"

class MyProfileData {
  MyProfileData({
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
      String occupation, 
      String age, 
      String biodata, 
      String location, 
      String sliderStatus, 
      String matchStatus, 
      String superpettySts, 
      String soundSts, 
      String fcmKey, 
      String msgStatus, 
      String image,}){
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
    _biodata = biodata;
    _location = location;
    _sliderStatus = sliderStatus;
    _matchStatus = matchStatus;
    _superpettySts = superpettySts;
    _soundSts = soundSts;
    _fcmKey = fcmKey;
    _msgStatus = msgStatus;
    _image = image;
}

  MyProfileData.fromJson(dynamic json) {
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
    _biodata = json['biodata'];
    _location = json['location'];
    _sliderStatus = json['slider_status'];
    _matchStatus = json['match_status'];
    _superpettySts = json['superpetty_sts'];
    _soundSts = json['sound_sts'];
    _fcmKey = json['fcm_key'];
    _msgStatus = json['msg_status'];
    _image = json['image'];
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
  String _occupation;
  String _age;
  String _biodata;
  String _location;
  String _sliderStatus;
  String _matchStatus;
  String _superpettySts;
  String _soundSts;
  String _fcmKey;
  String _msgStatus;
  String _image;

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
  String get occupation => _occupation;
  String get age => _age;
  String get biodata => _biodata;
  String get location => _location;
  String get sliderStatus => _sliderStatus;
  String get matchStatus => _matchStatus;
  String get superpettySts => _superpettySts;
  String get soundSts => _soundSts;
  String get fcmKey => _fcmKey;
  String get msgStatus => _msgStatus;
  String get image => _image;

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
    map['biodata'] = _biodata;
    map['location'] = _location;
    map['slider_status'] = _sliderStatus;
    map['match_status'] = _matchStatus;
    map['superpetty_sts'] = _superpettySts;
    map['sound_sts'] = _soundSts;
    map['fcm_key'] = _fcmKey;
    map['msg_status'] = _msgStatus;
    map['image'] = _image;
    return map;
  }

}