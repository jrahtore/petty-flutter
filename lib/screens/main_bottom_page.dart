import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:petty_app/api/location_update_api.dart';
import 'package:petty_app/api/user_details.dart';
import 'package:petty_app/models/profile.dart';
import 'package:petty_app/models/user_details_model.dart';
import 'package:petty_app/screens/bottom_navigation/nav_home.dart';
import 'package:petty_app/screens/setting/setting_page.dart';
import 'package:petty_app/screens/welcome_page.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/its_a_match_api.dart';
import '../api/package_price_api.dart';
import '../models/its_a_match_model.dart';
import '../services/firebase_auth.dart';
import '../services/location_service.dart';
import '../services/online_status.dart';
import '../utils/constant.dart';
import '../utils/urls.dart';
import 'bottom_navigation/menu_screen.dart';
import 'bottom_navigation/nav_inbox.dart';
import 'bottom_navigation/nav_matches.dart';
import 'its_a_match_screen.dart';

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
  'Petty notification id',
  'Petty notification',
  channelDescription: 'Petty notification permission',
  importance: Importance.max,
  priority: Priority.high,
);

class MainBottomPage extends StatefulWidget {
  static bool isConnected = false;
  @override
  _MainBottomPageState createState() => _MainBottomPageState();
}

class _MainBottomPageState extends State<MainBottomPage> {
  final newMatchSettings = '';
  StreamSubscription subscription;

  UserRequestModel userRequestModel;
  Profile profile;
  bool newMatchesNotification = true;
  String profileImage;
  
  //todo uncomment
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  bool isConnectionLost = false;
  //todo uncomment
  // void displayNotification(String title, String body) async {
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //   );
  // }

  Future<void> initLocalNotification() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//todo uncomment
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings();
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );

    final player = AudioCache();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (newMatchesNotification && message.notification != null) {
        ItsAMatchApi itsAMatchApi = ItsAMatchApi();
        ItsAMatchModel itsAMatchModel = await itsAMatchApi.getMatchDetails();
        var crush = itsAMatchModel.message.userlikeddata[0];

        if (crush.name != null &&
            crush.name.isNotEmpty &&
            profileImage != null &&
            profileImage.isNotEmpty &&
            crush.image != null &&
            crush.image.isNotEmpty &&
            crush.userId != null &&
            crush.userId.isNotEmpty) {
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                ItsAMatchScreen(
              name: crush.name,
              image: profileImage,
              user_liked_image: crush.image,
              userId: PettySharedPref.getUserId(prefs),
              friendUserId: crush.userId,
            ),
          );
        }

        if (prefs.getBool("soundEffect") == null ||
            prefs.getBool("soundEffect")) {
              final player = AudioPlayer();
              await player.play(('notification_sound.mp3'));
            
              }  }
    });
  }

  Future<void> saveTokenToDatabase(String token) async {
    await postData(token);
  }

  void postData(String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> queryparameters = {
        'user_id': PettySharedPref.getUserId(prefs),
        'fcm_key': token
      };
      var url = Uri.https(baseUrl, '/pettyapp/api/update_fcm', queryparameters);
      final response = await http.put(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      var items = json.decode(response.body)['message'] != null
          ? json.decode(response.body)['message']
          : [];
      print('fcm message : $items');
    } catch (e) {}
  }

  Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String token = await messaging.getToken();
    print('fcm token = $token');
    await saveTokenToDatabase(token);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  void initState() {
    print('MainBottomPage loaded');
    final userProfile = Get.put(UserProfile(), permanent: true);
    userRequestModel = new UserRequestModel(
      id: "",
    );
    profile = new Profile();
    super.initState();
//todo remove 22092022
    // _getCurrentLocation();

    refreshUser();
    initFirebaseMessaging();
    initLocalNotification();

    fetchPackDetails();

    setState(() {
      MainBottomPage.isConnected = true;
    });

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('subscription started');
      if (result == ConnectivityResult.none) {
        isConnectionLost = true;
        setState(() {
          // Get.snackbar("ERROR", "No Internet Connection",
          //     colorText: Colors.red);
          MainBottomPage.isConnected = false;
        });
      } else {
        if (isConnectionLost) {
          refreshUser();
          initFirebaseMessaging();
          initLocalNotification();

          fetchPackDetails();

          setState(() {
            MainBottomPage.isConnected = true;
          });
          UpdateOnlineOffline().updateIAmOnline();
        }

        print('connected');
      }
    });

    // final player = AudioCache();

    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     Get.snackbar("ERROR", "No Internet Connection", colorText: Colors.red);
    //   } else {
    //     Get.snackbar("SUCCESS", "Internet Connection established");
    //   }
    // });
    // var x = Provider.of<Categories>(context, listen: false).fetchCategories();
  }

  void fetchPackDetails() {
    PackagePriceApi().packagePriceGet();
  }

  Future refreshUser() async {
    print("refresh user");
    getUserId();
    apiCall();
    await LocationService().storeCurrentLocation();
    locationUpdateApiCall();
  }

  void locationUpdateApiCall() {
    LocationUpdateApi locationUpdateApi = new LocationUpdateApi();
    locationUpdateApi.locationUpdates().then((value) {
      if (value != null) {
        if (value.status == "success") {
          // final snackBar = SnackBar(
          //     content: Text('Location updated'),
          //     duration: const Duration(seconds: 3));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 3));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    });
  }

  void getUserId() async {
    print('getuserid called');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    userRequestModel.id = _userId;
    String _token = PettySharedPref.getAccessToken(prefs);
    userRequestModel.token = _token;
    if (prefs.getBool("matchesState") != null) {
      newMatchesNotification = prefs.getBool("matchesState");
    }

    if (FirebaseAuth.instance.currentUser == null) {
      FirebaseAuthService()
          .FirebaseLogin(_userId + '@gmail.com', _userId + 'akhil@');
    }
  }

  void apiCall() async {
    print("inside apicall");

    Get.find<UserProfile>().userDetails(userRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          profile.userId = value.data.userId;
          profile.name = value.data.name;
          profile.gender = value.data.gender;
          profile.age = value.data.age;
          profile.location = value.data.location;
          profile.countrycode = value.data.countrycode;
          profile.phone = value.data.phone;
          profile.image = value.data.image;
          profile.occupation = value.data.occupation;
          profile.bio = value.data.biodata;
          profile.superPettyStatus = value.data.superPettyStatus;
          profileImage = profile.image;

          try {
            SettingPage.age = double.parse(profile.age);
          } catch (e) {
            // print(e);
          }

          if (profile.image == null ||
              profile.image.isEmpty ||
              profile.image ==
                  '$baseUrlWithHttps/pettyapp/admin/profile_images/user.png') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return WelcomePage();
            }));
          }
        } else {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  var currentIndex = 0;

  //NavProfile(),  ];
  int _index = 0;
  double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    final _pages = [
      NavHome(),
      NavMatches(profile: profile),
      // PackageExpiryScreen(),
      NavInbox(),
      MenuScreen(profile: profile),
    ];
    // final userData = Provider.of<UserData>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0.3, color: Colors.grey),
          ),
        ),

        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Color(0xffB5B8CB),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    padding: EdgeInsets.all(12),
                    decoration: _index == 0
                        ? BoxDecoration(
                            color: _index == 0 ? Colors.red : Colors.white,
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffFF5F5D),
                                  Color(pinkColor),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          )
                        : BoxDecoration(color: Colors.white),
                    child: SvgPicture.asset(
                      'assets/images/homesvg.svg',
                      color: _index == 0 ? Colors.white : Color(0xff6D76AB),
                    ),
                  ),
                  // Image.asset(
                  //
                  //   'assets/home1.png',
                  //   height: iconSize,
                  //   width: iconSize,
                  // ),
                  // Icon(Icons.chat, color: Colors.white, size: 35),
                  label: 'Home',
                  // Text(
                  //   'Home',
                  //   style: TextStyle(
                  //     color: _index == 0 ? Colors.red : Color(0xffB5B8CB),
                  //   ),
                  // ),
                ),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: EdgeInsets.only(bottom: 2),
                      padding: EdgeInsets.all(12),
                      decoration: _index == 1
                          ? BoxDecoration(
                              color: _index == 1 ? Colors.red : Colors.white,
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFF5F5D),
                                    Color(pinkColor),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            )
                          : BoxDecoration(
                              color: Colors.white,
                            ),
                      child: SvgPicture.asset(
                        'assets/images/matchsvg.svg',
                        color: _index == 1 ? Colors.white : Color(0xff6D76AB),
                      ),
                    ),
                    // Image.asset(
                    //
                    //   'assets/home1.png',
                    //   height: iconSize,
                    //   width: iconSize,
                    // ),
                    // Icon(Icons.chat, color: Colors.white, size: 35),
                    label: 'Matches'
                    //   Text(
                    //   'Matches',
                    //   style: TextStyle(
                    //     color: _index == 1 ? Colors.red : Color(0xffB5B8CB),
                    //   ),
                    // ),
                    ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    padding: EdgeInsets.all(12),
                    decoration: _index == 2
                        ? BoxDecoration(
                            color: _index == 2 ? Colors.red : Colors.white,
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffFF5F5D),
                                  Color(pinkColor),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                          ),
                    child: SvgPicture.asset(
                      'assets/images/msgsvg.svg',
                      color: _index == 2 ? Colors.white : Color(0xff6D76AB),
                    ),
                  ),
                  // Image.asset(
                  //
                  //   'assets/home1.png',
                  //   height: iconSize,
                  //   width: iconSize,
                  // ),
                  // Icon(Icons.chat, color: Colors.white, size: 35),
                  label: 'Inbox',
                  // Text(
                  //   'Inbox',
                  //   style: TextStyle(
                  //     color: _index == 2 ? Colors.red : Color(0xffB5B8CB),
                  //   ),
                  // ),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    padding: EdgeInsets.all(12),
                    decoration: _index == 3
                        ? BoxDecoration(
                            color: _index == 3 ? Colors.red : Colors.white,
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffFF5F5D),
                                  Color(pinkColor),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                          ),
                    child: Icon(
                      Icons.menu,
                      color: _index == 3 ? Colors.white : Color(0xff6D76AB),
                    ),
                  ),

                  //   SvgPicture.asset(
                  //     'assets/images/usersvg.svg',
                  //     //color: _index == 3 ? Colors.white : Color(0xff6D76AB),
                  //   ),
                  // ),
                  label: 'Menu',

                  // Text(
                  //   'Menu',
                  //   style: TextStyle(
                  //     color: _index == 3 ? Colors.red : Color(0xffB5B8CB),
                  //   ),
                  // ),
                ),
              ],
              currentIndex: _index,
              onTap: (current) {
                setState(() {
                  _index = current;
                });
              }),
        ),
        // ),
        // ),
        //     ],
        //   ),
        // )
      ),
      body: _pages[_index],
    );
  }
}
