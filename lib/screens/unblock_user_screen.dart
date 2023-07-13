import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/block_unblock_user.dart';

class UnblockUser extends StatefulWidget {
  final String userId;
  const UnblockUser(this.userId, {Key key}) : super(key: key);

  @override
  State<UnblockUser> createState() => _UnblockUserState();
}

class _UnblockUserState extends State<UnblockUser> {
  Stream<DocumentSnapshot> _usersStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usersStream = FirebaseFirestore.instance
        .collection('BlockedUserList')
        // .doc(widget.userId)
        .doc(widget.userId)
        .snapshots();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usersStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: Platform.isAndroid ? false : true,
          title: Text(
            "Blocked Users",
            style: TextStyle(
                color: Color(0xff1E2661),
                fontFamily: "SFUIDisplay",
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          iconTheme: IconThemeData(color: Color(0xff1E2661)),
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _usersStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: const Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: const CircularProgressIndicator()));
              }

              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data.exists) {
                Map<String, dynamic> blockedUserMap =
                    (snapshot.data.data() as Map<String, dynamic>)['users'];
                List<dynamic> blockedUserNames = blockedUserMap.values.toList();

                print(blockedUserMap.toString());
                print(blockedUserNames);

                return ListView(children: () {
                  return List.generate(
                      blockedUserNames.length,
                      (index) => Column(
                            children: [
                              Material(
                                elevation: 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: ListTile(
                                    title: Text(
                                      blockedUserNames[index].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        var key =
                                            blockedUserMap.keys.toList()[index];
                                        blockedUserMap.remove(key);
                                        BlockUnblockUser().setUser(
                                            blockedUserMap,
                                            widget.userId,
                                            false,
                                            key);
                                      },
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                    leading: CircleAvatar(
                                      child: Text(blockedUserNames[index]
                                          .toString()[0]
                                          .toUpperCase()),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              )
                            ],
                          ));
                }());
              }
              return SizedBox();
            },
          ),
        ));
  }
}
