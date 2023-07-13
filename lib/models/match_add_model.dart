class MatchAddResponseModel {
  final String status;
  final String message;

  MatchAddResponseModel({this.status, this.message});
  factory MatchAddResponseModel.fromJson(Map<String, dynamic> json) {
    return MatchAddResponseModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
    );
  }
}

class MatchAddRequestModel {
  String userLikeId;
  String userId;
  String token;
  MatchAddRequestModel({this.userLikeId, this.token, this.userId});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_id': userId.trim(),
      'user_like_id': userLikeId.trim(),
      'token': token.trim(),
    };

    return map;
  }
}
