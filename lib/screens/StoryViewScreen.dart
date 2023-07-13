import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryPageView extends StatefulWidget {
  final List storyLinks;
  final String storyText;
  const StoryPageView({Key key, this.storyText, this.storyLinks})
      : super(key: key);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  final controller = StoryController();

  List<StoryItem> getStoryItems() {
    List<StoryItem> storyItemList = [];
    for (String storyLink in widget.storyLinks) {
      print('link = ' + storyLink);
      storyItemList.add(
        StoryItem.inlineImage(
          url: storyLink,
          controller: controller,
          duration: Duration(seconds: 10),
          caption: Text(
            widget.storyText ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          imageFit: BoxFit.contain,
          roundedTop: true,
        ),
      );
    }
    return storyItemList;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        storyItems: getStoryItems(),
        onComplete: () {
          Navigator.pop(context);
        },
        controller: controller,
        inline: true,
        repeat: false,
      ),
    );
  }
}
