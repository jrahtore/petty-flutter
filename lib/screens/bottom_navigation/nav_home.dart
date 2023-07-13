import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petty_app/models/slider_list_response.dart';
import 'package:petty_app/screens/SwipeAnimation/data.dart';
import 'package:petty_app/screens/go_premium_pkgs.dart';
import 'package:petty_app/services/user_browse_service.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/widgets/slider_card.dart';

class NavHome extends StatefulWidget {
  @override
  NavHomeState createState() => new NavHomeState();
}

class NavHomeState extends State<NavHome> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  List data = imageData;
  List selectedData = [];
  final _userBrowseService = UserBrowseService();

  void initState() {
    super.initState();

    init();
    fToast = FToast();
    fToast.init(context);

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -20.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);
          _buttonController.reset();
        }
      });
    });

    // right = new Tween<double>(
    //   begin: 0.0,
    //   end: 400.0,
    // ).animate(
    //   new CurvedAnimation(
    //     parent: _buttonController,
    //     curve: Curves.ease,
    //   ),
    // );

    // bottom = new Tween<double>(
    //   begin: 15.0,
    //   end: 100.0,
    // ).animate(
    //   new CurvedAnimation(
    //     parent: _buttonController,
    //     curve: Curves.ease,
    //   ),
    // );
    // width = new Tween<double>(
    //   begin: 20.0,
    //   end: 25.0,
    // ).animate(
    //   new CurvedAnimation(
    //     parent: _buttonController,
    //     curve: Curves.bounceOut,
    //   ),
    // );
  }

  void init() async {
    _userBrowseService.browseUsers();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  FToast fToast;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    timeDilation = 0.4;
    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return (new Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoPremiumPkgs(),
                    //welcomepage
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(
                  left: 14,
                  right: 14,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffeef2ff),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upgrade to Premium",
                          style: TextStyle(
                              color: Color(0xff5278FC),
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Unlock Petty Box for Free!",
                          style: TextStyle(
                            color: Color(0xff6386fc),
                            fontFamily: "myfonts",
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/images/crownsvg.svg",
                      color: Color(0xff6386fc),
                      width: 35,
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder<List<SliderListResponse>>(
                stream: _userBrowseService.usersBrowsed,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: Text(
                        "No Profile Found!",
                        style: TextStyle(color: Colors.pink, fontSize: 18),
                      ),
                    );
                  if (!snapshot.hasData || snapshot.data == null)
                    return Expanded(
                      child: CircularProgressIndicator(),
                    );

                  final users = snapshot.data ?? <SliderListResponse>[];
                 // print("here is data " + snapshot.data.length.toString());
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    width: _mediaQuery.size.width,
                    height: _mediaQuery.size.height,
                    child: snapshot.data.length > 0
                        ? Stack(
                            fit: StackFit.expand,
                            alignment: AlignmentDirectional.center,
                            children: users.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final user = entry.value;
                                return SliderCard(index: index, user: user);
                              },
                            ).toList(),
                          )
                        : Center(
                            child: Container(
                              child: new Text(
                                "No More Results !",
                                style: new TextStyle(
                                    color: Color(pinkColor), fontSize: 20.0),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
