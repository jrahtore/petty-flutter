import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/bottom_navigation/chat_detail.dart';

class ChatTile extends StatefulWidget {
  String userId, image, name, friendsUserId, distance, business;
  ChatTile(
      this.userId, this.image, this.name, this.friendsUserId, this.distance,
      {this.business, Key key})
      : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  //todo uncomment
  // Timestamp timestamp;
  String user;
  int isMessageSeenInt = -10;

  var smallTextStyle = TextStyle(
      color: Color(0xff928899),
      fontFamily: "SFUIDisplay",
      fontWeight: FontWeight.w300,
      fontSize: 13);
  //todo uncomment
  // StreamSubscription<QuerySnapshot> stream;
  // queryFirebaseLastMsgTime() {
  //   List userIds = [widget.userId, widget.friendsUserId];
  //   userIds.sort();
  //   CollectionReference messageSnapshots = FirebaseFirestore.instance
  //       .collection(userIds[0])
  //       .doc('friend')
  //       .collection(userIds[1]);
  //   Query query = messageSnapshots.orderBy('time', descending: true).limit(1);
  //
  //   stream = query.snapshots().listen((event) {
  //     if (event.docs.isNotEmpty) {
  //       setState(() {
  //         user = event.docs.first.get('user');
  //         if (event.docs.first.get('message') != null)
  //           lastMessage = event.docs.first.get('message');
  //         timestamp = event.docs.first.get('time');
  //       });
  //     }
  //   });
  // }

  // getTime() {
  //   //todo uncomment
  //   if (timestamp != null) {
  //     DateTime date = timestamp.toDate();
  //     return DateFormat.jm().format(date).toString();
  //   }
  //   return 'now';
  // }

//   Future<bool> isMessageSeen() async {
//     if (user != null && user != widget.userId) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       Map map = {};
//       String openTime;
//       if (PettySharedPref.getTimeStampMapChat(prefs) != null) {
//         String timeStampMap = PettySharedPref.getTimeStampMapChat(prefs);
//
//         map = jsonDecode(timeStampMap);
//       }
//
//       if (map[widget.friendsUserId] != null) {
//         openTime = map[widget.friendsUserId];
//
//         // openedTimeStamp = openTime as Timestamp;
// //todo uncomment
//         isMessageSeenInt =
//             timestamp.toDate().compareTo(DateTime.parse(openTime));
//       }
//     }
//     return false;
//   }

  @override
  void initState() {
    //todo uncomment
    // queryFirebaseLastMsgTime();
    super.initState();
  }

  @override
  void dispose() {
    //todo uncomment
    // if (stream != null) stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              isMessageSeenInt = -10;
            });

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatDetail(
                  friendsImage: widget.image,
                  friendsName: widget.name,
                  userId: widget.userId,
                  friendsUserId: widget.friendsUserId,
                ),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.image),
            radius: 33,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.name,
              style: TextStyle(
                  color: Color(0xff1E2661),
                  fontFamily: "SFUIDisplay",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          subtitle: Text(
            widget.business ?? 'Searching for petties',
            style: smallTextStyle,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/location.svg',
                  height: 20,
                  width: 20,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '${widget.distance} away ',
                  style: smallTextStyle,
                )
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
