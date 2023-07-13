/// status : "success"
/// message : "photo list"
/// data : [{"img_id":"6","img":"https://petrysample.tk/pettyapp/admin/profile_images/img5.jpg"},{"img_id":"7","img":"https://petty.sample.tk/pettyapp/admin/profile_images/img5.jpg"},{"img_id":"8","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45img5.jpg"},{"img_id":"9","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45img5.jpg"},{"img_id":"10","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45placeholder-image.png"},{"img_id":"11","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45dp"},{"img_id":"12","img":"https://petty.
/// sample.tk/pettyapp/admin/profile_images/45dp"},{"img_id":"13","img":"https://.tk/pettyapp/admin/profile_images/45dp"},{"img_id":"14","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45image_picker4545069117135234949.jpg"},{"img_id":"15","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45image_picker2354513369839997231.jpg"},{"img_id":"16","img":"https://petty.sample.tk/pettyapp/admin/profile_images/45image_picker8039168605763438907.jpg"}]

class ImageListResponse {
  ImageListResponse({
    String status,
    String message,
    List<ImageData> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ImageListResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(ImageData.fromJson(v));
      });
    }
  }
  String _status;
  String _message;
  List<ImageData> _data;

  String get status => _status;
  String get message => _message;
  List<ImageData> get data => _data;

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

/// img_id : "6"
/// img : "https://petty.sample.tk/pettyapp/admin/profile_images/img5.jpg"

class ImageData {
  ImageData({
    String imgId,
    String img,
  }) {
    _imgId = imgId;
    _img = img;
  }

  ImageData.fromJson(dynamic json) {
    _imgId = json['img_id'];
    _img = json['img'];
  }
  String _imgId;
  String _img;

  String get imgId => _imgId;
  String get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['img_id'] = _imgId;
    map['img'] = _img;
    return map;
  }
}
