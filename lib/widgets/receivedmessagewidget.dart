// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty_app/screens/utils.dart';

import '../services/chat_type_selection.dart';

class ReceivedMessagesWidget extends StatefulWidget {
  Map<String, dynamic> snapshot;
  String profileImage;
  //todo uncomment add @required this.timestamp at position 0 after {
  Timestamp timestamp;
  ReceivedMessagesWidget(this.snapshot,
      {@required this.timestamp, @required this.profileImage});

  @override
  State<ReceivedMessagesWidget> createState() => _ReceivedMessagesWidgetState();
}

class _ReceivedMessagesWidgetState extends State<ReceivedMessagesWidget> {
  // VideoPlayerController _controller;
  getTime() {
    //todo uncomment and remove below line
    // return '';
    DateTime date = widget.timestamp.toDate();
    return DateFormat.jm().format(date).toString();
  }

  // @override
  // void dispose() {
  //   if (_controller != null) _controller.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.snapshot['video'] != null &&
  //       widget.snapshot['video'].isNotEmpty) {
  //     _controller = VideoPlayerController.network(widget.snapshot['video'])
  //       ..initialize().then((value) {
  //         setState(() {});
  //       });
  //   }
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
  //                   child: _controller.value.isInitialized
  //                       ? AspectRatio(
  //                           aspectRatio: _controller.value.aspectRatio,
  //                           child: VideoPlayer(_controller),
  //                         )
  //                       : Container(),
  //                 ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> showFullScreenImageVideo(
  //     BuildContext context, bool isImage) async {
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
    //     onTap: () {
    //       showFullScreenImageVideo(context, chatTypes == ChatTypes.image);
    //     },
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              CircleAvatar(
                backgroundImage: widget.profileImage != null
                    ? NetworkImage(widget.profileImage)
                    : AssetImage('assets/images/aysh.png'),
              ),
              SizedBox(
                width: 10.0,
              ),

              // CircleAvatar(
              //   backgroundColor: Colors.black,
              //   child: Icon(Icons.person),
              // ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(lightPink),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    //bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: getChildWidget(context),
              ),
            ],
          ),
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 5.5),
            child: Text(
              getTime(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .apply(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
