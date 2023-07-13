import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:petty_app/api/match_list_api.dart';
import 'package:petty_app/api/match_story_list_api.dart';
import 'package:petty_app/models/match_list_response.dart';
import 'package:petty_app/models/profile.dart';
import 'package:petty_app/module/petties_list.dart';
import 'package:petty_app/screens/bottom_navigation/matches_list.dart';
import 'package:petty_app/screens/bottom_navigation/mystory_list.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/widgets/filter_widget.dart';
import 'package:petty_app/widgets/matches_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/match_story_list.dart';
import '../StoryViewScreen.dart';
import '../main_bottom_page.dart';

class NavMatches extends StatefulWidget {
  static double minAge = 18;
  static double maxAge = 99;
  static double maxDistance = 500;
  static double minDistance = 0;
  static bool isCheckBoxEnabled = false;

  final Profile profile;

  NavMatches({
    Key key,
    this.profile,
  }) : super(key: key);

  @override
  _NavMatchesState createState() => _NavMatchesState();
}

class _NavMatchesState extends State<NavMatches> {
  String _currentLocation;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return DriveDialogBox();
    //       });


  // showDialog<String>(
  //   context: context,
  //   builder: (BuildContext context) => new AlertDialog(
  //     title: new Text("title"),
  //     content: new Text("Message"),
  //     actions: <Widget>[
  //       new FlatButton(
  //         child: new Text("OK"),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ],
  //   ),
  // );
// });
  }

  _getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _currentLocation = PettySharedPref.getLocation(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      MainBottomPage.isConnected;
    });
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xffee1d7f3),
              Color(0xfffaf0f3),
            ],
            center: Alignment(0, -1),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/garyprofile.svg',
                  // ),
                  CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: widget.profile.image != "" &&
                              MainBottomPage.isConnected
                          ? NetworkImage(widget.profile.image)
                          : AssetImage("assets/images/user.png")
                      // AssetImage("assets/images/user.png"),

                      ),

                  SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profile.name = widget.profile.name.isNotEmpty &&
                                widget.profile.name != null
                            ? widget.profile.name[0].toUpperCase() +
                                widget.profile.name.substring(1)
                            : 'Name',
                        style: TextStyle(
                            color: Color(0xff1E2661),
                            fontFamily: "SFUIDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/images/map.png"),
                          SizedBox(
                            width: 7,
                          ),
                          _currentLocation != null
                              ? Text(
                                  _currentLocation,
                                  style: TextStyle(color: Color(0xff6D76AB)),
                                )
                              : Text(
                                  "Location",
                                  style: TextStyle(color: Color(0xff6D76AB)),
                                ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),

              // SvgPicture.asset(
              //   'assets/images/petytext.svg',
              //   color: Colors.white,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "All That ",
                    style: TextStyle(
                        color: Color(textColor),
                        fontWeight: FontWeight.bold,
                        fontFamily: "SFUIDisplay",
                        fontSize: 16),
                  ),
                  Text(
                    "Petty Sh*t ",
                    style: TextStyle(
                        color: Color(
                          0xffFF1C7E,
                        ),
                        fontWeight: FontWeight.bold,
                        fontFamily: "SFUIDisplay",
                        fontSize: 16),
                  ),
                  Text(
                    "Pays Off",
                    style: TextStyle(
                        color: Color(textColor),
                        fontWeight: FontWeight.bold,
                        fontFamily: "SFUIDisplay",
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        //color: Color(greyColor),
                        //color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            value;
                          });
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(greyColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(greyColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(greyColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(pinkColor),
                              size: 20,
                            ),
                            //border: InputBorder.none,
                            hintText: "Search for Petties ",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Filter by',
                        content: FilterWidget(),
                        confirm: TextButton(
                          onPressed: () {
                            Get.back();
                            setState(() {
                              NavMatches.minAge;
                              NavMatches.maxAge;
                              NavMatches.maxDistance;
                              NavMatches.minDistance;
                              NavMatches.isCheckBoxEnabled;
                            });
                          },
                          child: Text('OK'),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(greyColor),
                          ),
                          //color: Color(greyColor),
                          //color: Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Image.asset("assets/images/filter.png")),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyStoryListPage(
                                    profile: widget.profile,
                                  )));
                    },
                    child: Container(
                      width: 75,
                      height: 75,
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(27)),
                        border: Border.all(color: Colors.green[500], width: 3),
                      ),
                      child: Container(
                        width: 75,
                        height: 75,
                        child: Icon(
                          Icons.add,
                          size: 45,
                          color: Color(0xff1E2661),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(27)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75,

                      //padding: EdgeInsets.all(5),
                      child: buildPettiesList(),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Petty People",
                          style: TextStyle(
                              color: Color(0xff1E2661),
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        //Image.asset("assets/images/awesome.png"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchesListPage()));
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: Color(textColor),
                          fontFamily: "SFUIDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Expanded(
                child: FutureBuilder<List<Message>>(
                    future: MatchListApiService().fetchMatchList(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text(
                            "No matches found !",
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              if (_controller != null &&
                                  _controller.text.isNotEmpty) {
                                if (snapshot.data[index].name
                                    .toLowerCase()
                                    .contains(_controller.text.toLowerCase())) {
                                  return MatchesContainer(index, snapshot);
                                }
                                return Container();
                              } else {
                                if (!NavMatches.isCheckBoxEnabled) {
                                  print(snapshot.data[index].age);
                                  try {
                                    if (int.parse(snapshot.data[index].age) >=
                                            NavMatches.minAge &&
                                        int.parse(snapshot.data[index].age) <=
                                            NavMatches.maxAge) {
                                      return MatchesContainer(index, snapshot);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  return Container();
                                } else {
                                  //check for minDistance and MaxDistance
                                  print(
                                      'distance = ${snapshot.data[index].distance}');
                                  String distanceWithMiles =
                                      snapshot.data[index].distance;
                                  String distance =
                                      distanceWithMiles.split('m').first;
                                  try {
                                    if (double.parse(distance) != null &&
                                        double.parse(distance) >=
                                            NavMatches.minDistance.toDouble() &&
                                        double.parse(distance) <=
                                            NavMatches.maxDistance.toDouble()) {
                                      if (int.parse(snapshot.data[index].age) >=
                                              NavMatches.minAge &&
                                          int.parse(snapshot.data[index].age) <=
                                              NavMatches.maxAge) {
                                        return MatchesContainer(
                                            index, snapshot);
                                      }
                                      return Container();
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                  return Container();
                                }
                              }
                            });
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildPettiesList() {
    return FutureBuilder<List<StoryContent>>(
        future: MatchStoryListApiService().fetchMatchStory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(),
            );
          } else {
            print('snapshot = ' + snapshot.data.toString());
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 75,
                    height: 75,
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(27)),
                      border: Border.all(
                        color: Colors.red[500],
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoryPageView(
                                    storyLinks: snapshot.data[index].story,
                                    storyText: snapshot.data[index].name,
                                  ))),
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(27)),
                          image: DecorationImage(
                            image: snapshot.data[index].story != null
                                ? NetworkImage(snapshot.data[index].story[0])
                                : AssetImage("assets/images/user.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
    // return ListView.builder(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemCount: pettiesList.length,
    //   itemBuilder: (context, index) {
    //     return buildPettiesItems(context, index);
    //   },
    // );
  }

  Widget buildPettiesItems(BuildContext context, int index) {
    return Container(
      width: 75,
      height: 75,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(27)),
        border: Border.all(
          color: Colors.red[500],
        ),
      ),
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(27)),
          image: DecorationImage(
            image: AssetImage(pettiesList[index].pettyimg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
