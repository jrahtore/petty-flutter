enum ChatTypes {
  image,
  video,
  document,
  message,
  location,
}

class ChatType {
  Map<String, dynamic> _snapshot = {};
  ChatType(this._snapshot);

  ChatTypes getChatType() {
    if (_snapshot['message'] != null && _snapshot['message'].isNotEmpty) {
      return ChatTypes.message;
    } else if (_snapshot['video'] != null && _snapshot['video'].isNotEmpty) {
      return ChatTypes.video;
    } else if (_snapshot['image'] != null && _snapshot['image'].isNotEmpty) {
      return ChatTypes.image;
    } else if (_snapshot['file'] != null && _snapshot['file'].isNotEmpty) {
      return ChatTypes.document;
    } else if (_snapshot['location'] != null &&
        _snapshot['location'].isNotEmpty) {
      return ChatTypes.location;
    } else {
      return null;
    }
  }
}
