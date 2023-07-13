/// status : "success"
/// message : "story list"
/// data : [{"story":"https://petty.sample.tk/pettyapp/admin/story_images/45istockphoto-184276818-170667a.jpeg","story_id":"17","name":"Sajay"},{"story":"https://petty.sample.tk/pettyapp/admin/story_images/45image_picker6741235929341209493.jpg","story_id":"26","name":"Sajay"},{"story":"https://petty.sample.tk/pettyapp/admin/story_images/45image_picker7314031572935948878.jpg","story_id":"27","name":"Sajay"},{"story":"https://petty.sample.tk/pettyapp/admin/story_images/45image_picker296814055350555923.jpg","story_id":"28","name":"Sajay"}]

class MyStoryListResponse {
  MyStoryListResponse({
    String status,
    String message,
    List<MyStoryListData> data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  MyStoryListResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(MyStoryListData.fromJson(v));
      });
    }
  }
  String _status;
  String _message;
  List<MyStoryListData> _data;

  String get status => _status;
  String get message => _message;
  List<MyStoryListData> get data => _data;

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

/// story : "https://petty.sample.tk/pettyapp/admin/story_images/45istockphoto-184276818-170667a.jpeg"
/// story_id : "17"
/// name : "Sajay"

class MyStoryListData {
  MyStoryListData({
    String story,
    String storyId,
    String name,
  }) {
    _story = story;
    _storyId = storyId;
    _name = name;
  }

  MyStoryListData.fromJson(dynamic json) {
    _story = json['story'];
    _storyId = json['story_id'];
    _name = json['name'];
  }
  String _story;
  String _storyId;
  String _name;

  String get story => _story;
  String get storyId => _storyId;
  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['story'] = _story;
    map['story_id'] = _storyId;
    map['name'] = _name;
    return map;
  }
}
