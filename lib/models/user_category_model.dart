class UserCategoryModel {
  UserCategoryModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  UserCategoryModel.fromJson(dynamic json) {
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
  UserCategoryModel copyWith({
    String status,
    String message,
    List<Data> data,
  }) =>
      UserCategoryModel(
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
    String categoryName,
    String catImg,
  }) {
    _categoryName = categoryName;
    _catImg = catImg;
  }

  Data.fromJson(dynamic json) {
    _categoryName = json['category_name'];
    _catImg = json['cat_img'];
  }
  String _categoryName;
  String _catImg;
  Data copyWith({
    String categoryName,
    String catImg,
  }) =>
      Data(
        categoryName: categoryName ?? _categoryName,
        catImg: catImg ?? _catImg,
      );
  String get categoryName => _categoryName;
  String get catImg => _catImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    map['cat_img'] = _catImg;
    return map;
  }
}
