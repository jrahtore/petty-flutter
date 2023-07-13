class FacebookModel {
  FacebookModel({
    String name,
    String email,
    Picture picture,
    String birthday,
    String gender,
    String id,
  }) {
    _name = name;
    _email = email;
    _picture = picture;
    _birthday = birthday;
    _gender = gender;
    _id = id;
  }

  FacebookModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
    _birthday = json['birthday'];
    _gender = json['gender'];
    _id = json['id'];
  }
  String _name;
  String _email;
  Picture _picture;
  String _birthday;
  String _gender;
  String _id;
  FacebookModel copyWith({
    String name,
    String email,
    Picture picture,
    String birthday,
    String gender,
    String id,
  }) =>
      FacebookModel(
        name: name ?? _name,
        email: email ?? _email,
        picture: picture ?? _picture,
        birthday: birthday ?? _birthday,
        gender: gender ?? _gender,
        id: id ?? _id,
      );
  String get name => _name;
  String get email => _email;
  Picture get picture => _picture;
  String get birthday => _birthday;
  String get gender => _gender;
  String get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    if (_picture != null) {
      map['picture'] = _picture.toJson();
    }
    map['birthday'] = _birthday;
    map['gender'] = _gender;
    map['id'] = _id;
    return map;
  }
}

class Picture {
  Picture({
    Data data,
  }) {
    _data = data;
  }

  Picture.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data _data;
  Picture copyWith({
    Data data,
  }) =>
      Picture(
        data: data ?? _data,
      );
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    int height,
    bool isSilhouette,
    String url,
    int width,
  }) {
    _height = height;
    _isSilhouette = isSilhouette;
    _url = url;
    _width = width;
  }

  Data.fromJson(dynamic json) {
    _height = json['height'];
    _isSilhouette = json['is_silhouette'];
    _url = json['url'];
    _width = json['width'];
  }
  int _height;
  bool _isSilhouette;
  String _url;
  int _width;
  Data copyWith({
    int height,
    bool isSilhouette,
    String url,
    int width,
  }) =>
      Data(
        height: height ?? _height,
        isSilhouette: isSilhouette ?? _isSilhouette,
        url: url ?? _url,
        width: width ?? _width,
      );
  int get height => _height;
  bool get isSilhouette => _isSilhouette;
  String get url => _url;
  int get width => _width;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['height'] = _height;
    map['is_silhouette'] = _isSilhouette;
    map['url'] = _url;
    map['width'] = _width;
    return map;
  }
}
