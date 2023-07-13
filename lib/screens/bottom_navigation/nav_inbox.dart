import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/widgets/chat_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/petty_shared_pref.dart';
import '../../utils/urls.dart';
import '../../widgets/shimmer_widget.dart';

class NavInbox extends StatefulWidget {
  @override
  _NavInboxState createState() => _NavInboxState();
}

class _NavInboxState extends State<NavInbox> {
  String _userId;
  String _token;
  List messageData = [];
  final _controller = TextEditingController();
  List<Widget> messagesList = [];
  List blockedUsers = [];
  bool isLoading = true;
  Color lightGrey = Color(0xffbbb5c0);

  void fetchData() async {
    var queryParameter = {'user_id': _userId, 'token': _token};
    var url = Uri.https(
        baseUrl, '/pettyapp/api/match_store_notification', queryParameter);
    final response = await http.get(url, headers: {
      "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
    });

    if (response.statusCode == 200) {
      var items = json.decode(response.body)['message'] != null
          ? json.decode(response.body)['message']
          : messageData;

      if (mounted) {
        setState(() {
          if (items.runtimeType != String) messageData = items;
          isLoading = false;
        });
      }
    } else if (response.statusCode == 400) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      final snackBar = SnackBar(
          content: Text('Server is busy'),
          duration: const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = PettySharedPref.getUserId(prefs);
    _token = PettySharedPref.getAccessToken(prefs);
    await fetchData();
    // BlockUser().getBlockedUsers();
  }

  getChats() {
    messagesList = [];
    for (var messages in messageData) {
      String image = messages['image'] ?? 'assets/images/pettyone.png';
      String distance = messages['distance'] ?? '0 miles';
      String name = messages['name'] ?? 'Name';
      String friendsUserId = messages['user_id'] ?? 'user';
      String business = messages['occupation'];
      // String lastMessage = messages['image']!=null ? messages['image'] : 'assets/images/pettyone.png';
      // String time = messages['image']!=null ? messages['image'] : 'assets/images/pettyone.png';
      if (_controller != null &&
          _controller.text.isNotEmpty &&
          name.toLowerCase().contains(_controller.text.toLowerCase())) {
        messagesList.add(
          ChatTile(
            _userId,
            image,
            name,
            friendsUserId,
            distance,
            business: business,
            key: ValueKey(messageData.indexOf(messages)),
          ),
        );
      } else if (_controller != null && _controller.text.isEmpty) {
        messagesList.add(
          ChatTile(
            _userId,
            image,
            name,
            friendsUserId,
            distance,
            business: business,
            key: ValueKey(messageData.indexOf(messages)),
          ),
        );
      }
    }
    print('chat list length = ${messagesList.length}');
    return messagesList;
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF3F5F7),
                        //color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            value;
                          });
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Color(greyColor), width: 1.0),
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
                          border: InputBorder.none,
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //       color: Color(greyColor), width: 1.0),
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
                            child: SvgPicture.asset(
                              'assets/search.svg',
                              color: Colors.grey[400],
                            ),
                          ),
                          //border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Pick your Choice',
                      style: TextStyle(
                          color: Color(0xff1E2661),
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'You can choose the favorite people you like and can connect them',
                      style: TextStyle(
                          color: lightGrey,
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),

              isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: ShimmerWidget(),
                        ),
                      ),
                    )
                  : Column(
                      children: getChats(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
