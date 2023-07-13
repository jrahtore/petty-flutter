// To parse this JSON data, do
//
//     final matchStoryList = matchStoryListFromJson(jsonString);

class MatchStoryList {
  String status;
  String message;
  List<StoryContent> storyList = [];
  String user_id, user_like_id, story, story_id, name, photo_link;

  List<StoryContent> getMatchList(Map map) {
    status = map['status'] ?? 'failed';
    message = map['message'] ?? 'failed';
    Map<String, dynamic> data = map['data'] ?? {};
    List<String> uidList = [];

    for (int i = 0; i < data.length - 1; i++) {
      Map m = data[i.toString()];
      if (uidList.contains(m['user_like_id'])) {
        int pos = uidList.indexOf(m['user_like_id']);
        StoryContent storyContent = storyList.elementAt(pos);
        storyContent.story.add(m['story']);
      } else {
        StoryContent storyContent = StoryContent(m['user_id'],
            m['user_like_id'], [m['story']], m['story_id'], m['photo_link']);
        storyList.add(storyContent);
        uidList.add(m['user_like_id']);
      }
    }

    return storyList;
  }
}

class StoryContent {
  String user_id, user_like_id, story_id, name, photo_link;
  List<String> story = [];
  StoryContent(this.user_id, this.user_like_id, this.story, this.story_id,
      this.photo_link);
}
