/// status : "success"
/// message : "Faq found"
/// data : [{"faq_id":"1","question":"Is this Petty Free to use?","answer":"The petty is based in free package and types of petty pass specs.","status":"1"},{"faq_id":"2","question":"More friendly?","answer":"Do you want dating with one.","status":"1"},{"faq_id":"4","question":"Type of payment?","answer":"In progressing.","status":"1"},{"faq_id":"5","question":"Trust in security?","answer":"Will keep personal info.","status":"1"},{"faq_id":"6","question":"Duration of petty?","answer":"based on package.","status":"1"}]

class FaqModel {
  FaqModel({
    String status,
    String message,
    List<Data> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FaqModel.fromJson(dynamic json) {
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
  FaqModel copyWith({
    String status,
    String message,
    List<Data> data,
  }) =>
      FaqModel(
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

/// faq_id : "1"
/// question : "Is this Petty Free to use?"
/// answer : "The petty is based in free package and types of petty pass specs."
/// status : "1"

class Data {
  Data({
    String faqId,
    String question,
    String answer,
    String status,
  }) {
    _faqId = faqId;
    _question = question;
    _answer = answer;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _faqId = json['faq_id'];
    _question = json['question'];
    _answer = json['answer'];
    _status = json['status'];
  }
  String _faqId;
  String _question;
  String _answer;
  String _status;
  Data copyWith({
    String faqId,
    String question,
    String answer,
    String status,
  }) =>
      Data(
        faqId: faqId ?? _faqId,
        question: question ?? _question,
        answer: answer ?? _answer,
        status: status ?? _status,
      );
  String get faqId => _faqId;
  String get question => _question;
  String get answer => _answer;
  String get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['faq_id'] = _faqId;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    return map;
  }
}
