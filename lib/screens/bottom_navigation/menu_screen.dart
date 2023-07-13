import 'package:flutter/material.dart';
import 'package:petty_app/models/logout_model.dart';
import 'package:petty_app/models/profile.dart';
import 'package:petty_app/screens/bottom_navigation/nav_profile.dart';
import 'package:petty_app/screens/setting/setting_page.dart';
import 'package:petty_app/utils/logout_alertdialog.dart';

import '../main_bottom_page.dart';

class MenuScreen extends StatefulWidget {
  final Profile profile;
  MenuScreen({
    Key key,
    this.profile,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //final AuthService _auth = AuthService();

  bool isLogOut = false;

  LogOutRequestModel logOutRequestModel = new LogOutRequestModel();
  void initState() {
    super.initState();
    logOutRequestModel = new LogOutRequestModel(
      userId: "",
      token: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      MainBottomPage.isConnected;
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Menu",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavProfile()));
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
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
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.profile.name =
                                  widget.profile.name.isNotEmpty &&
                                          widget.profile.name != null
                                      ? widget.profile.name[0].toUpperCase() +
                                          widget.profile.name.substring(1)
                                      : 'Name',
                              style: TextStyle(
                                  fontFamily: "SFUIDisplay",
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "See your profile",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "SFUIDisplay",
                                  fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.grey,
                          size: 40,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  //Navigator.pop(context);
                  var dialog = LogoutAlertDialog(
                      title: "LogOut",
                      message: "Are you sure you want to LogOut?",
                      onPostivePressed: () {},
                      positiveBtnText: "YES",
                      negativeBtnText: "NO");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void logoutApicall() {
  //   LogOut logOut = new LogOut();
  //   logOut.logout(logOutRequestModel).then((value) {
  //     if (value != null) {
  //       print("inside api call");
  //       setState(() {
  //         isLogOut = false;
  //       });
  //       if (value.message == "success") {
  //         print("Message: " + value.message);
  //         final snackBar = SnackBar(
  //             content: Text(value.message),
  //             duration: const Duration(seconds: 1));
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         isLogOut = true;

  //         if (isLogOut) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => Authenticate()),
  //             // (Route<dynamic> route) => false,
  //           );
  //         }
  //       } else {
  //         final snackBar = SnackBar(
  //             content: Text(value.message),
  //             duration: const Duration(seconds: 1));
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         print(value.message);
  //       }
  //     }
  //   });
  // }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';

// import '../../models/profile.dart';
// import '../../provider/provider.dart';
// import '../../widgets/bold_text.dart';
// import '../../widgets/choice_buttons.dart';
// import '../../widgets/custom_container.dart';
// import '../../widgets/read_more.dart';
// import '../go_premium_pkgs.dart';
// import '../main_bottom_page.dart';

// class MenuScreen extends StatefulWidget {
//   static double minAge = 18;
//   static double maxAge = 99;
//   static double maxDistance = 500;
//   static double minDistance = 0;
//   static bool isCheckBoxEnabled = false;

//   final Profile profile;
//   MenuScreen({
//     Key key,
//     this.profile,
//   }) : super(key: key);

//   //NavMatches({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   String _currentLocation;
//   final _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ConnectionProvider(),
//       child: Consumer<ConnectionProvider>(builder: (context, model, child) {
//         int currentIndex = 0;

//         TabController _tabController;
//         var _controller;
//         return DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             body: SingleChildScrollView(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 290,
//                       child: Stack(
//                         children: [
//                           Container(
//                             width: double.infinity,
//                             height: 260,
//                             //width: ,
//                             child: Image.asset(
//                               'assets/images/postImage.png',
//                               fit: BoxFit.cover,
//                               // width: 500,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8.0, left: 10, right: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.person_add,
//                                       color: Colors.white,
//                                       size: 30,
//                                     )),
//                                 Text(
//                                   widget.profile.name = widget
//                                               .profile.name.isNotEmpty &&
//                                           widget.profile.name != null
//                                       ? widget.profile.name[0].toUpperCase() +
//                                           widget.profile.name.substring(1)
//                                       : 'Name',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: "SFUIDisplay",
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.more_horiz_outlined,
//                                       color: Colors.white,
//                                       size: 30,
//                                     ))
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             // top: 100,
//                             left: 270,
//                             bottom: 1,
//                             child: Container(
//                               margin: EdgeInsets.only(top: 20),
//                               child: CircleAvatar(
//                                 radius: 45,
//                                 backgroundColor: Colors.white,
//                                 child: CircleAvatar(
//                                     radius: 42,
//                                     backgroundColor: Colors.white,
//                                     backgroundImage: widget.profile.image !=
//                                                 "" &&
//                                             MainBottomPage.isConnected
//                                         ? NetworkImage(widget.profile.image)
//                                         : AssetImage("assets/images/user.png")
//                                     // AssetImage("assets/images/user.png"),

//                                     ),
//                                 // CircleAvatar(
//                                 //   radius: 40,
//                                 //   backgroundImage:
//                                 //       AssetImage('assets/p2.png'),
//                                 // ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 210,
//                             left: 10,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.profile.name = widget
//                                               .profile.name.isNotEmpty &&
//                                           widget.profile.name != null
//                                       ? widget.profile.name[0].toUpperCase() +
//                                           widget.profile.name.substring(1)
//                                       : 'Name',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: "SFUIDisplay",
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22),
//                                 ),
//                                 Text(
//                                   'Acrochat',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             top: 270,
//                             left: 10,
//                             child: Text(
//                               widget.profile.phone =
//                                   widget.profile.phone.isNotEmpty &&
//                                           widget.profile.name != null
//                                       ? widget.profile.phone[0].toUpperCase() +
//                                           widget.profile.phone.substring(1)
//                                       : 'Phone Number',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: "SFUIDisplay",
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16),
//                             ),
//                             // Text(
//                             //   'Phone Number',
//                             //   style: TextStyle(
//                             //       fontWeight: FontWeight.bold, fontSize: 18),
//                             // ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Location',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset("assets/images/map.png"),
//                                 SizedBox(
//                                   width: 7,
//                                 ),
//                                 _currentLocation != null
//                                     ? Text(
//                                         _currentLocation,
//                                         style:
//                                             TextStyle(color: Color(0xff6D76AB)),
//                                       )
//                                     : Text(
//                                         "Location",
//                                         style: TextStyle(
//                                             color: Color(0xff6D76AB),
//                                             fontSize: 22),
//                                       ),
//                               ],
//                             ),

//                             SizedBox(
//                               height: 10,
//                             ),
//                             Divider(
//                               thickness: 1,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'About',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
                            
//                             //  Text(
//                             //'My name is Leslie Alexander and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..'),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             ReadMoreText(
//                                 text:widget.profile.bio =
//                                   widget.profile.bio.isNotEmpty &&
//                                           widget.profile.bio != null
//                                       ? widget.profile.bio[0].toUpperCase() +
//                                           widget.profile.bio.substring(1)
//                                       : 'Phone Number',
                            
//                                 //
//                                    // ' My name is Leslie Alexander and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..'),
//                      ) ,
                   
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Interests',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     //choice button start
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ChoiceButton(
//                           onpress: () {
//                             model.changeBorderColor(0);
//                           },
//                           BText: "Travelling",
//                           style: TextStyle(
//                               color: model.index == 0
//                                   ? Color(0xffFF4181)
//                                   : Colors.black),
//                           color: model.index == 0 ? Colors.green : Colors.white,
//                           BorderColor: model.index == 0
//                               ? Color(0xffFF4181)
//                               : Colors.white,
//                         ),
//                         ChoiceButton(
//                           onpress: () {
//                             model.changeBorderColor(1);
//                           },
//                           BText: "Books",
//                           style: TextStyle(
//                               color: model.index == 1
//                                   ? Color(0xffFF4181)
//                                   : Colors.black),
//                           color: model.index == 1 ? Colors.green : Colors.white,
//                           BorderColor: model.index == 1
//                               ? Color(0xffFF4181)
//                               : Colors.white,
//                         ),
//                         ChoiceButton(
//                           onpress: () {
//                             model.changeBorderColor(2);
//                           },
//                           BText: "Music",
//                           style: TextStyle(
//                               color: model.index == 2
//                                   ? Color(0xffFF4181)
//                                   : Colors.black),
//                           color: model.index == 2 ? Colors.green : Colors.white,
//                           BorderColor: model.index == 2
//                               ? Color(0xffFF4181)
//                               : Colors.white,
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ChoiceButton(
//                           onpress: () {
//                             model.changeBorderColor(3);
//                           },
//                           BText: "Dancing",
//                           style: TextStyle(
//                               color: model.index == 3
//                                   ? Color(0xffFF4181)
//                                   : Colors.black),
//                           color: model.index == 3 ? Colors.green : Colors.white,
//                           BorderColor: model.index == 3
//                               ? Color(0xffFF4181)
//                               : Colors.white,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         ChoiceButton(
//                           onpress: () {
//                             model.changeBorderColor(4);
//                           },
//                           BText: "Modelling",
//                           style: TextStyle(
//                               color: model.index == 4
//                                   ? Color(0xffFF4181)
//                                   : Colors.black),
//                           color: model.index == 4 ? Colors.green : Colors.white,
//                           BorderColor: model.index == 4
//                               ? Color(0xffFF4181)
//                               : Colors.white,
//                         )
//                       ],
//                     ),
// //choice button ends
//                     SizedBox(
//                       height: 20,
//                     ),

//                     CustomContainer(
//                       img: "assets/images/premium.svg",
//                       txt1: 'Petty Pass',
//                       txt2:
//                           'Be the top profile in your area for the next 30 minutes and get more matches.',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     CustomContainer(
//                       img: "assets/images/premium.svg",
//                       txt1: 'Petty Pass',
//                       txt2:
//                           'Be the top profile in your area for the next 30 minutes and get more matches.',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     CustomContainer(
//                       img: "assets/images/pettypass.svg",
//                       txt1: 'Petty Pass',
//                       txt2:
//                           'Be the top profile in your area for the next 30 minutes and get more matches.',
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Photos'),
//                         Text(
//                           'Uploaded',
//                           style: TextStyle(color: Color(0xffFF4181)),
//                         )
//                       ],
//                     ),

// //tab bar start

//                     Container(
//                       child: TabBar(
//                         labelColor: Color(0xffFF4181),
//                         indicatorWeight: 2,
//                         indicatorSize: TabBarIndicatorSize.label,
//                         indicatorColor: Color(0xffFF4181),
//                         unselectedLabelColor: Color(0xffFF4181),
//                         controller: _controller,
//                         tabs: [
//                           Tab(
//                             child: Image.asset('assets/images/photos.png'),
//                           ),
//                           Tab(
//                             child: Image.asset(
//                                 'assets/images/uploaded_photos.png'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 300,
//                       width: double.infinity,
//                       child: TabBarView(
//                         controller: _controller,
//                         children: <Widget>[
//                           Card(
//                             color: Colors.transparent,
//                             elevation: 0,
//                             child: GridView.count(
//                               shrinkWrap: true,
//                               primary: false,
//                               padding: EdgeInsets.all(4),
//                               childAspectRatio: 0.80 / 1,
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 0,
//                               crossAxisSpacing: 2,
//                               children: [
//                                 (Container(
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 InkWell(
//                                   onTap: (() {}),
//                                   child: (Container(
//                                     child:
//                                         Image.asset('assets/images/img6.png'),
//                                   )),
//                                 ),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img6.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                               ],
//                             ),
//                           ),
//                           Card(
//                             elevation: 0,
//                             color: Colors.transparent,
//                             child: GridView.count(
//                               shrinkWrap: true,
//                               primary: false,
//                               padding: EdgeInsets.all(4),
//                               childAspectRatio: 0.80 / 1,
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 0,
//                               crossAxisSpacing: 2,
//                               children: [
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 InkWell(
//                                   onTap: (() {}),
//                                   child: (Container(
//                                     child:
//                                         Image.asset('assets/images/img6.png'),
//                                   )),
//                                 ),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img6.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img6.png'),
//                                 )),
//                                 (Container(
//                                   height: 80,
//                                   width: 40,
//                                   child: Image.asset('assets/images/img5.png'),
//                                 )),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

// //tab bar ends

//                     SizedBox(
//                       height: 10,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'See All',
//                         style: TextStyle(color: Color(0xffFF4181)),
//                       ),
//                     )
//                   ]),

//               //
//             ),
//          ]),
//                     ), ),
//         );
//       }),
//     );
//   }
// }
