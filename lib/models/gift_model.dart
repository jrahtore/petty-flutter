class GiftModel {
  GiftModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GiftModel.fromJson(dynamic json) {
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
    String giftName,
    String giftDescription,
    String giftSpec,
    String imageName,
  }) {
    _giftName = giftName;
    _giftDescription = giftDescription;
    _giftSpec = giftSpec;
    _imageName = imageName;
  }

  Data.fromJson(dynamic json) {
    _giftName = json['gift_name'];
    _giftDescription = json['gift_description'];
    _giftSpec = json['gift_spec'];
    _imageName = json['image_name'];
  }
  String _giftName;
  String _giftDescription;
  String _giftSpec;
  String _imageName;

  String get giftName => _giftName;
  String get giftDescription => _giftDescription;
  String get giftSpec => _giftSpec;
  String get imageName => _imageName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gift_name'] = _giftName;
    map['gift_description'] = _giftDescription;
    map['gift_spec'] = _giftSpec;
    map['image_name'] = _imageName;
    return map;
  }
}
