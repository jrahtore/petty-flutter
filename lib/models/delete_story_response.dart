class DeleteStoryResponseModel {
  final String status;
  final String message;

  DeleteStoryResponseModel({this.status, this.message});
  factory DeleteStoryResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteStoryResponseModel(
      status: json["status"] != null ? json["status"] : "",
      message: json["message"] != null ? json["message"] : "",

    );
  }
}

class DeleteStoryRequestModel {
  String storyId;
  String userId;
  String token;
  DeleteStoryRequestModel({this.storyId, this.token, this.userId});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId.trim(),
      'story_id': storyId.trim(),
      'token': token.trim(),
    };
    print("story_id: " + storyId);

    return map;
  }
}
