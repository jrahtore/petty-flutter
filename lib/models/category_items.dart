class CategoryItems {
  CategoryItems({
    String status,
    String message,
    String image,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _image = image;
  }

  CategoryItems.fromJson(dynamic json) {
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
  String _image;
  CategoryItems copyWith({
    String status,
    String message,
    List<Data> data,
  }) =>
      CategoryItems(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
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
    String status,
    String image,
  }) {
    _id = id;
    _categoryName = categoryName;
    _status = status;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    _status = json['status'];
    _image = json['category_image'] ?? '';
  }
  String _id;
  String _categoryName;
  String _status;
  String _image;
  Data copyWith({
    String id,
    String categoryName,
    String status,
    String image,
  }) =>
      Data(
        id: id ?? _id,
        categoryName: categoryName ?? _categoryName,
        status: status ?? _status,
        image: image ?? _image,
      );
  String get id => _id;
  String get categoryName => _categoryName;
  String get status => _status;
  String get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_name'] = _categoryName;
    map['status'] = _status;
    map['category_image'] = _image;
    return map;
  }
}
