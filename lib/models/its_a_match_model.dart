class ItsAMatchModel {
  ItsAMatchModel({
    String status,
    Message message,
  }) {
    _status = status;
    _message = message;
  }

  ItsAMatchModel.fromJson(dynamic json) {
    _status = json['status'];
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }
  String _status;
  Message _message;

  String get status => _status;
  Message get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message.toJson();
    }
    return map;
  }
}

class Message {
  Message({
    List<Userlikeddata> userlikeddata,
  }) {
    _userlikeddata = userlikeddata;
  }

  Message.fromJson(dynamic json) {
    if (json['userlikeddata'] != null) {
      _userlikeddata = [];
      json['userlikeddata'].forEach((v) {
        _userlikeddata.add(Userlikeddata.fromJson(v));
      });
    }
  }
  List<Userlikeddata> _userlikeddata;

  List<Userlikeddata> get userlikeddata => _userlikeddata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userlikeddata != null) {
      map['userlikeddata'] = _userlikeddata.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Userlikeddata {
  Userlikeddata({
    String userId,
    String name,
    String age,
    dynamic username,
    String photoLink,
    String image,
  }) {
    _userId = userId;
    _name = name;
    _age = age;
    _username = username;
    _photoLink = photoLink;
    _image = image;
  }

  Userlikeddata.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _age = json['age'];
    _username = json['username'];
    _photoLink = json['photo_link'];
    _image = json['image'];
  }
  String _userId;
  String _name;
  String _age;
  dynamic _username;
  String _photoLink;
  String _image;

  String get userId => _userId;
  String get name => _name;
  String get age => _age;
  dynamic get username => _username;
  String get photoLink => _photoLink;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['age'] = _age;
    map['username'] = _username;
    map['photo_link'] = _photoLink;
    map['image'] = _image;
    return map;
  }
}
