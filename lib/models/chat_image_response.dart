class ChatImageResponse {
  ChatImageResponse({
    String status,
    String message,
    Data data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ChatImageResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String _status;
  String _message;
  Data _data;
  ChatImageResponse copyWith({
    String status,
    String message,
    Data data,
  }) =>
      ChatImageResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  String get status => _status;
  String get message => _message;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }
}

/// resource_id : "4"
/// url : "https://petty.sample.tk/pettyapp/admin/chat_images/image_picker2703741545551132199.jpg"

class Data {
  Data({
    String resourceId,
    String url,
  }) {
    _resourceId = resourceId;
    _url = url;
  }

  Data.fromJson(dynamic json) {
    _resourceId = json['resource_id'];
    _url = json['url'];
  }
  String _resourceId;
  String _url;
  Data copyWith({
    String resourceId,
    String url,
  }) =>
      Data(
        resourceId: resourceId ?? _resourceId,
        url: url ?? _url,
      );
  String get resourceId => _resourceId;
  String get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resource_id'] = _resourceId;
    map['url'] = _url;
    return map;
  }
}
