class ChatBackgroundModel {
  ChatBackgroundModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ChatBackgroundModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String id,
    String image,
    String date,
  }) {
    _id = id;
    _image = image;
    _date = date;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _date = json['date'];
  }
  String _id;
  String _image;
  String _date;

  String get id => _id;
  String get image => _image;
  String get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['date'] = _date;
    return map;
  }
}
