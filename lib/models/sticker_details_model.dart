class StickerDetailsModel {
  StickerDetailsModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  StickerDetailsModel.fromJson(dynamic json) {
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
    String catId,
    String stickerName,
    String status,
    String image,
  }) {
    _id = id;
    _catId = catId;
    _stickerName = stickerName;
    _status = status;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _catId = json['cat_id'];
    _stickerName = json['sticker_name'];
    _status = json['status'];
    _image = json['image'];
  }
  String _id;
  String _catId;
  String _stickerName;
  String _status;
  String _image;

  String get id => _id;
  String get catId => _catId;
  String get stickerName => _stickerName;
  String get status => _status;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cat_id'] = _catId;
    map['sticker_name'] = _stickerName;
    map['status'] = _status;
    map['image'] = _image;
    return map;
  }
}
