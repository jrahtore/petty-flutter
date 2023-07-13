class BlockedUsersResponse {
  BlockedUsersResponse({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  BlockedUsersResponse.fromJson(dynamic json) {
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
  BlockedUsersResponse copyWith({
    String status,
    String message,
    List<Data> data,
  }) =>
      BlockedUsersResponse(
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
    String blockedUserid,
  }) {
    _blockedUserid = blockedUserid;
  }

  Data.fromJson(dynamic json) {
    _blockedUserid = json['blocked_userid'];
  }
  String _blockedUserid;
  Data copyWith({
    String blockedUserid,
  }) =>
      Data(
        blockedUserid: blockedUserid ?? _blockedUserid,
      );
  String get blockedUserid => _blockedUserid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['blocked_userid'] = _blockedUserid;
    return map;
  }
}
