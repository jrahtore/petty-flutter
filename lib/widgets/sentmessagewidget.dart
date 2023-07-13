// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty_app/screens/utils.dart';
import 'package:petty_app/services/chat_type_selection.dart';

class SentMessageWidget extends StatefulWidget {
  Map<String, dynamic> snapshot;
  //todo change datetime to Timestamp
  Timestamp timestamp;
  bool isSelected;

  SentMessageWidget(this.snapshot,
      {@required this.timestamp, this.isSelected = false});

  @override
  State<SentMessageWidget> createState() => _SentMessageWidgetState();
}

class _SentMessageWidgetState extends State<SentMessageWidget> {
  // VideoPlayerController _controller;
  getTime() {
    if (widget.timestamp != null) {
      //todo delete next line then uncomment
      // DateTime date = widget.timestamp;
      DateTime date = widget.timestamp.toDate();
      return DateFormat.jm().format(date).toString();
    }
    return 'now';
  }

  // @override
  // void dispose() {
  //   if (_controller != null) _controller.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // if (widget.snapshot['video'] != null &&
  //     widget.snapshot['video'].isNotEmpty) {
  // _controller = VideoPlayerController.network(widget.snapshot['video'])
  //   ..initialize().then((value) {
  //     setState(() {});
  //   });
  // }
  // }

  // getImageOrVideo(BuildContext context, bool isImage) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: _controller != null && _controller.value.isPlaying
  //             ? () async {
  //                 _controller.pause();
  //                 _controller.seekTo(Duration(seconds: 0));
  //                 return true;
  //               }
  //             : () async {
  //                 return true;
  //               },
  //         child: AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           insetPadding: EdgeInsets.all(0.0),
  //           contentPadding: EdgeInsets.all(0.0),
  //           content: isImage == true
  //               ? Image.network(
  //                   widget.snapshot['image'],
  //                 )
  //               : Center(
  //                   child:
  //                       _controller != null && _controller.value.isInitialized
  //                           ? AspectRatio(
  //                               aspectRatio: _controller.value.aspectRatio,
  //                               child: VideoPlayer(_controller),
  //                             )
  //                           : Container(),
  //                 ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // push(BuildContext context) {
  // void showFullScreenImageVideo(BuildContext context, bool isImage) async {
  //   if (isImage == true) {
  //     getImageOrVideo(context, isImage);
  //   } else {
  //     if (_controller != null && _controller.value.isInitialized) {
  //       getImageOrVideo(context, isImage);
  //       _controller.play();
  //     }
  //   }
  // }

  getChildWidget(BuildContext context) {
    ChatType chatType = ChatType(widget.snapshot);
    ChatTypes chatTypes = chatType.getChatType();

    if (chatTypes == ChatTypes.message) {
      return Text(
        widget.snapshot['message'],
        style: Theme.of(context).textTheme.bodyText1.apply(
              color: Color(mainColor),
            ),
      );
    }
    // else if (chatTypes == ChatTypes.video) {
    //   return InkWell(
    //     onTap: widget.isSelected == false
    //         ? () {
    //             showFullScreenImageVideo(context, chatTypes == ChatTypes.image);
    //           }
    //         : () {},
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Center(
    //           child: _controller != null && _controller.value.isInitialized
    //               ? AspectRatio(
    //                   aspectRatio: _controller.value.aspectRatio,
    //                   child: VideoPlayer(_controller),
    //                 )
    //               : Container(
    //                   height: 100,
    //                   child: Center(
    //                     child: CircularProgressIndicator(),
    //                   ),
    //                 ),
    //         ),
    //         Icon(
    //           Icons.play_circle_fill,
    //           color: Colors.grey[300],
    //         ),
    //       ],
    //     ),
    //   );
    // }
    else if (chatTypes == ChatTypes.image) {
      return CachedNetworkImage(
        height: 100.0,
        width: 100.0,
        imageUrl: widget.snapshot['image'],
      );
    }
    // else if (chatTypes == ChatTypes.document) {
    // return FileDownloadContainer(
    //   widget.snapshot['file'],
    // );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isSelected ? Colors.blue[50] : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .6),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Color(bgColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: getChildWidget(context),
                  ),
                ],
              ),
              Text(
                getTime(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
