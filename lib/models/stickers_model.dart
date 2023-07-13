class StickersModel {
  StickersModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  StickersModel.fromJson(dynamic json) {
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
    String categoryName,
  }) {
    _id = id;
    _categoryName = categoryName;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['category_name'];
  }
  String _id;
  String _categoryName;

  String get id => _id;
  String get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_name'] = _categoryName;
    return map;
  }
}
