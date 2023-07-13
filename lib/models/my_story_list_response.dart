// To parse this JSON data, do
//
//     final myStorylistResponse = myStorylistResponseFromJson(jsonString);

import 'dart:convert';

MyStorylistResponse myStorylistResponseFromJson(String str) =>
    MyStorylistResponse.fromJson(json.decode(str));

String myStorylistResponseToJson(MyStorylistResponse data) =>
    json.encode(data.toJson());

class MyStorylistResponse {
  MyStorylistResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory MyStorylistResponse.fromJson(Map<String, dynamic> json) =>
      MyStorylistResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.the0,
    this.pics,
  });

  The0 the0;
  List<String> pics;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the0: The0.fromJson(json["0"]),
        pics: List<String>.from(json["pics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "0": the0.toJson(),
        "pics": List<dynamic>.from(pics.map((x) => x)),
      };
}

class The0 {
  The0({
    this.story,
    this.storyId,
    this.name,
  });

  String story;
  String storyId;
  String name;

  factory The0.fromJson(Map<String, dynamic> json) => The0(
        story: json["story"],
        storyId: json["story_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "story": story,
        "story_id": storyId,
        "name": name,
      };
}
