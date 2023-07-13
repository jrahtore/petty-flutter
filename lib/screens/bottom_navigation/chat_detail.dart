//import 'package:demoapp/models/petties_list.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petty_app/screens/utils.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/block_unblock_user.dart';
import '../../api/chat_file_controller.dart';
import '../../api/chat_image_controller.dart';
import '../../api/report_user_api.dart';
import '../../module/chat_popup_menu_tile.dart';
import '../../widgets/stickers.dart';
import '../custom_wallpaper_screen.dart';

List<String> reportTitleList = [
  'Inappropriate pictures',
  'Sexual chat / pictures',
  'Spam / advertising',
  'Harassment',
  'Fraud',
  'Other'
];

enum EmojiOrSticker { emoji, sticker, none }

class ChatDetail extends StatefulWidget {
  final String userId;
  final String friendsUserId;
  final String friendsName;
 
  final String friendsImage;
  const ChatDetail(
      {this.userId, this.friendsImage, this.friendsName, this.friendsUserId});
  @override
  _ChatDetailState createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  var _controller = TextEditingController();
  bool isTextEmpty = true;
  List<String> userIds = [];
  String collectionName;
  CollectionReference messageSnapshots;
  List<String> _selectedItems = [];
  bool isSelectionStarted = false;
  String imageSource;
  final ChatImageController imageController = Get.put(ChatImageController());
  final ChatFileController fileController = Get.put(ChatFileController());
  bool isUserBlocked = false;
  bool amIBlocked = false;
  EmojiOrSticker _emojiOrSticker = EmojiOrSticker.none;
  FocusNode _focusNode = FocusNode();
  bool isFriendOnline = false;
  int limit = 60;
  int dropDownValue = 0;
  String backgroundImage = '';
  final TextEditingController _additionalDetailsController =
      TextEditingController();
  final TextStyle _textStyle = const TextStyle(
    fontSize: 20,
  );
  bool isLoading = false;
  Map<String, dynamic> blockedUserList = {};
  StreamSubscription stream, stream1;
  Stream<QuerySnapshot<Map<String, dynamic>>> stream0;

//todo uncomment
  Query<Map<String, dynamic>> query;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // imageController.dispose();
    // fileController.dispose();
    print('dispose called');
    stream.cancel();
    stream1.cancel();
    stream0 = null;
  }

  // List<DropdownMenuItem> getDropDownMenuItems() {
  //   return reportTitles
  //       .map((e) => DropdownMenuItem(
  //             child: Text(e),
  //             value: reportTitles.indexOf(e),
  //             //value argument is required if more than one item
  //           ))
  //       .toList();
  // }
  // return List.generate(
  //   reportTitles.length,
  //   (index) => DropdownMenuItem(
  //     child: Text(reportTitles[index]),
  //     value: index,
  //     //value argument is required if more than one item
  //   ),
  // );

  saveUserLoggedTime() async {
    Map timestampMap = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String timestamp = DateTime.now().toString();
    if (PettySharedPref.getTimeStampMapChat(prefs) != null) {
      timestampMap = jsonDecode(PettySharedPref.getTimeStampMapChat(prefs));
    }
    timestampMap[widget.friendsUserId] = timestamp;
    PettySharedPref.setTimeStampMapChat(prefs, jsonEncode(timestampMap));
  }

  getBgImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundImage = PettySharedPref.getChatBG(prefs);
    });
  }

  @override
  void initState() {
    super.initState();

    getBgImage();

    userIds = [widget.userId, widget.friendsUserId];
    userIds.sort();
    //todo uncomment
    messageSnapshots = FirebaseFirestore.instance
        .collection(userIds[0])
        .doc('friend')
        .collection(userIds[1]);
    query = messageSnapshots.orderBy('time', descending: true).limit(limit);
    stream0 = query.snapshots();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('has focus');
        setState(() {
          _emojiOrSticker = EmojiOrSticker.none;
        });
      }
    });

    saveUserLoggedTime();
    updateIAmOnline();

    stream = FirebaseFirestore.instance
        .collection('BlockedUserList')
        .doc(widget.userId)
        .snapshots()
        .listen((event) {
      print('blocked user list updated');
      if (event != null && event.exists) {
        blockedUserList = event.data()['users'] as Map<String, dynamic>;
        setState(() {
          isUserBlocked =
              blockedUserList[widget.friendsUserId] == null ? false : true;
        });
      }
    });
    stream1 = FirebaseFirestore.instance
        .collection('AmIBlocked')
        .doc(widget.userId)
        .snapshots()
        .listen((event) {
      print('am i blocked list updated');
      if (event != null && event.exists) {
        if ((event.data()['blocked']).contains(widget.friendsUserId)) {
          setState(() {
            amIBlocked = true;
          });
        }
      }
    });
  }

  Future<void> updateIAmOnline() async {
    //todo uncomment
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('OnlineStatus')
        .doc(widget.friendsUserId);
    documentReference.snapshots().listen((event) {
      print('i am online updated');
      if (event.exists && event.get('isOnline') != null) {
        setState(() {
          isFriendOnline = event.get('isOnline');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(backgroundImage);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                backgroundImage: widget.friendsImage != null
                    ? NetworkImage(widget.friendsImage)
                    : AssetImage('assets/images/aysh.png'),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.friendsName,
                  style: TextStyle(fontSize: 12, color: Color(mainColor)),
                ),
                Text(
                  isFriendOnline ? 'Online' : 'Offline',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Color(mainColor),
            ),
          ),
        ),
        actions: [
          isSelectionStarted
              ? IconButton(
                  onPressed: () {
                    deletemsg();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.blue,
                  ),
                )
              : SizedBox(),
          PopupMenuButton<int>(
            onSelected: (result) async {
              if (result == 0) {
                backgroundImage = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CustomWallpaperScreen()),
                );
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                PettySharedPref.setChatBG(sharedPreferences, backgroundImage);
                setState(() {});
              } else if (result == 2) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setModalState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Title',
                                    style: _textStyle,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  DropdownButton(
                                      items: reportTitleList
                                          .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value:
                                        reportTitleList.indexOf(e),
                                        //value argument is required if more than one item
                                      ))
                                          .toList(),
                                      value: dropDownValue,
                                      onChanged: (value) {
                                        dropDownValue = value;
                                        setModalState(() {
                                          dropDownValue;
                                        });
                                      }),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Additional details',
                                style: _textStyle,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                maxLines: 5,
                                minLines: 3,
                                controller: _additionalDetailsController,
                                decoration: InputDecoration(
                                    hintText: 'Additional details',
                                    border: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (!isLoading) {
                                      isLoading = true;
                                      String message =
                                          reportTitleList[dropDownValue] +
                                              ' --> ' +
                                              _additionalDetailsController.text;
                                      bool isSuccess = await ReportUserApi()
                                          .postReport(
                                          widget.friendsUserId, message);
                                      isLoading = false;
                                      if (isSuccess) {
                                        _additionalDetailsController.clear();
                                        Get.back();
                                      }
                                      isSuccess
                                          ? Get.snackbar(
                                          "Success", 'Report user success',
                                          duration:
                                          const Duration(seconds: 2))
                                          : Get.snackbar("Failed",
                                          'Something went wrong. Try again',
                                          duration:
                                          const Duration(seconds: 2));
                                    }
                                  },
                                  child: Text(
                                    'SUBMIT',
                                    style: _textStyle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).viewInsets.bottom,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
            },
            icon: Image.asset("assets/images/dots.png"),
            offset: const Offset(0, 50),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: PopUpMenuTile(
                    icon: Icons.image,
                    title: 'Wallpaper',
                    color: Colors.black,
                    iconColor: Colors.blue,
                  )),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  enabled: !isUserBlocked,
                  onTap: () {
                    blockedUserList.putIfAbsent(widget.friendsUserId, () {
                      return widget.friendsName;
                    });
                    BlockUnblockUser().setUser(blockedUserList, widget.userId,
                        true, widget.friendsUserId);
                  },
                  value: 1,
                  child: PopUpMenuTile(
                    icon: Icons.block_outlined,
                    title: 'Block User',
                    color: isUserBlocked ? Colors.red[200] : Colors.red,
                    iconColor: Colors.red,
                  )),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 2,
                  child: PopUpMenuTile(
                    icon: Icons.report_gmailerrorred_outlined,
                    title: 'Report User',
                  )),
            ],
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: backgroundImage != null && backgroundImage.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(backgroundImage), fit: BoxFit.cover)
              : null,
        ),
        child: Column(
          children: [
            //todo uncomment
            Expanded(
              child: !isUserBlocked && !amIBlocked
                  ? StreamBuilder<QuerySnapshot>(
                      stream: stream0,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List list =
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          return data['user'] == widget.userId
                              ? GestureDetector(
                                  onLongPress: () {
                                    _selectedItems.add(document.id);
                                    if (isSelectionStarted == false)
                                      isSelectionStarted = true;
                                    // _showMyDialog(document.id);
                                    setState(() {});
                                  },
                                  onTap: () {
                                    if (isSelectionStarted == true)
                                      _selectedItems.contains(document.id)
                                          ? _selectedItems.remove(document.id)
                                          : _selectedItems.add(document.id);
                                    setState(() {});
                                  },
                                  child: _selectedItems.contains(document.id)
                                      ? SentMessageWidget(
                                          data,
                                          timestamp: data['time'],
                                          isSelected: true,
                                        )
                                      : SentMessageWidget(
                                          data,
                                          timestamp: data['time'],
                                        ),
                                )
                              : ReceivedMessagesWidget(
                                  data,
                                  timestamp: data['time'],
                                  profileImage: widget.friendsImage,
                                );
                        }).toList();
                        if (snapshot.data.docs.length > 60) {
                          list.add(Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  query = messageSnapshots
                                      .orderBy('time', descending: true)
                                      .limit(limit += 60);
                                });
                              },
                              child: Text(
                                'Load more',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ));
                        }

                        return ListView(reverse: true, children: list);
                      })
                  : Center(
                      child: Text(
                        'User blocked',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(bgColor),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            iconSize: 25,
                            padding: EdgeInsets.all(0.0),
                            splashRadius: 2.0,
                            color: _emojiOrSticker == EmojiOrSticker.none
                                ? Colors.grey[700]
                                : Colors.blue,
                            onPressed: () {
                              setState(() {
                                _emojiOrSticker != EmojiOrSticker.none
                                    ? _emojiOrSticker = EmojiOrSticker.none
                                    : _emojiOrSticker = EmojiOrSticker.emoji;
                                _focusNode.unfocus();
                                _focusNode.canRequestFocus = true;
                              });
                            },
                            icon: Icon(Icons.sentiment_satisfied),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text.isNotEmpty &&
                          !isUserBlocked &&
                          !amIBlocked) {
                        //todo uncomment
                        messageSnapshots.add({
                          'message': _controller.text,
                          'user': widget.userId,
                          'time': FieldValue.serverTimestamp(),
                          'friend': widget.friendsUserId
                        });
                        _controller.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Color(mainColor), shape: BoxShape.circle),
                      child: Icon(
                        Icons.send,
                        //todo
                        // isTextEmpty ? Icons.keyboard_voice : Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            WillPopScope(
              onWillPop: () async {
                if (_emojiOrSticker != EmojiOrSticker.none) {
                  setState(() {
                    _emojiOrSticker = EmojiOrSticker.none;
                  });
                  return false;
                }
                return true;
              },
              child: Visibility(
                visible: _emojiOrSticker != EmojiOrSticker.none,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 250,
                      child: _emojiOrSticker == EmojiOrSticker.emoji
                          ? EmojiPicker(
                              onEmojiSelected: (category, emoji) {
                                _controller.text =
                                    '${_controller.text}${emoji.emoji}';
                                _controller.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _controller.text.length));
                                // Do something when emoji is tapped
                              },
                              onBackspacePressed: () {
                                if (_controller.text != null &&
                                    _controller.text.length > 0) {
                                  _controller.text = _controller.text.characters
                                      .skipLast(1)
                                      .string;
                                  _controller.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _controller.text.length));
                                }
                                // Backspace-Button tapped logic
                                // Remove this line to also remove the button in the UI
                              },
                              config: Config(
                                  columns: 7,
                                  emojiSizeMax: 32 *
                                      (Platform.isIOS
                                          ? 1.30
                                          : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: Colors.white,
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                //  CircularProgressIndicator: Colors.blue ,
                                  backspaceColor: Colors.blue,
                                  skinToneDialogBgColor: Colors.white,
                                  skinToneIndicatorColor: Colors.grey,
                                  enableSkinTones: true,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                //  noRecentsText: "No Recents",
                                //   noRecentsStyle:  TextStyle(
                                //       fontSize: 20, color: Colors.black26),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons:  CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL),
                            )
                          : Stickers(
                              isUserBlocked: isUserBlocked,
                              amIBlocked: amIBlocked,
                              messageSnapshots: messageSnapshots,
                              friendsUserId: widget.friendsUserId,
                              userId: widget.userId,
                            ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _emojiOrSticker = EmojiOrSticker.emoji;
                              });
                            },
                            icon: Icon(
                              Icons.emoji_emotions_sharp,
                              color: _emojiOrSticker == EmojiOrSticker.emoji
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _emojiOrSticker = EmojiOrSticker.sticker;
                              });
                            },
                            icon: Icon(
                              Icons.note_rounded,
                              color: _emojiOrSticker == EmojiOrSticker.sticker
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deletemsg() {
    //todo uncomment
    var db = FirebaseFirestore.instance;
    var batch = db.batch();
    for (String id in _selectedItems) {
      batch.delete(db.collection(collectionName).doc(id));
    }
    batch.commit();
    if (isSelectionStarted == true) {
      _selectedItems.clear();
      isSelectionStarted = false;
      setState(() {});
    }
  }
}

// List<IconData> icons = [
//   Icons.image,
//   Icons.camera,
//   Icons.file_upload,
//   Icons.folder,
//   Icons.gif
// ];
