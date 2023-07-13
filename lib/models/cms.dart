class CmsResponseModel {
  final String status;
  final String message;
  final Data data;
  //final Data data;
  CmsResponseModel({this.status, this.message, this.data});
  factory CmsResponseModel.fromJson(Map<String, dynamic> json) {
    return CmsResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",
      //data: json["data"] != null ? json["data"] : "",
      data: json["data"] != null
          ? new Data.fromJson(json['data'])
          : new Data(content: "Default", caption: "default"),
    );
  }
}

class CmsRequestModel {
  String type;
  CmsRequestModel({this.type});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'type': type.trim(),
    };
    print("Model Type:" + this.type);
    return map;
  }
}

class Data {
  String content;
  String caption;

  Data({this.caption, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['caption'] = this.caption;

    return data;
  }
}
