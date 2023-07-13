import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:petty_app/api/cms_fetching.dart';
import 'package:petty_app/api/faq_fetching.dart';
import 'package:petty_app/api/settings_update_api.dart';
import 'package:petty_app/api/update_age.dart';
import 'package:petty_app/models/cms.dart';
import 'package:petty_app/models/settings_update_model.dart';
import 'package:petty_app/module/setting_items_model.dart';
import 'package:petty_app/screens/setting/cms_screen.dart';
import 'package:petty_app/screens/unblock_user_screen.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/utils/delete_alertdialog.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/slider_list_response.dart';
import '../../services/user_browse_service.dart';
import '../bioscreen.dart';
import '../go_premium_pkgs.dart';
import '../pettypass_screen.dart';
import '../superpetty_screen.dart';
import '../user_detail_screen/user_detail_screen.dart';
import 'faq_screen.dart';
// import '../services/auth.dart';/

class SettingPage extends StatefulWidget {
  final SliderListResponse user;
  final int index;
  const SettingPage({this.user, this.index, Key key}) : super(key: key);
  static double age = 25.0;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserBrowseService _userBrowseService = UserBrowseService();
  int lightBlack = 0xff444444;
  CmsRequestModel cmsRequestModel;
  String _currentLocation;
  String type = "0";
  String content = "";
  String caption = "";
  bool isLoading = false;
  bool isAgeDragging = false;

  bool shwoMeInCard = true,
      newMatches = true,
      superPetty = false,
      messages = true,
      soundEffects = true;

  SettingsUpdateRequestModel settingsUpdateRequestModel =
      SettingsUpdateRequestModel();

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    settingsUpdateRequestModel.userId = PettySharedPref.getUserId(prefs);
    settingsUpdateRequestModel.token = PettySharedPref.getAccessToken(prefs);
  }

  Future refreshUser() async {
    setState(() {
      getUserId();
    });
  }

  loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", type);
  }

  //SETTINGS UPDATE
  setCardState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("cardState", state);
  }

  checkCardState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("cardState") != null) {
      shwoMeInCard = prefs.getBool("cardState");
    }
  }

  setMatchesState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("matchesState", state);
  }

  checkMatchesState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("matchesState") != null) {
      newMatches = prefs.getBool("matchesState");
    }
  }

  setPettyState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("pettyState", state);
  }

  checkPettyState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("pettyState") != null) {
      superPetty = prefs.getBool("pettyState");
    }
  }

  setSoundEffects(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("soundEffect", state);
  }

  checkSoundEffects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("soundEffect") != null) {
      soundEffects = prefs.getBool("soundEffect");
    }
  }

  setMessageState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("messageState", state);
  }

  checkMessageState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("messageState") != null) {
      messages = prefs.getBool("messageState");
    }
  }

  @override
  void initState() {
    cmsRequestModel = new CmsRequestModel(type: type);
    super.initState();
    //SETTINGS UPDATE
    checkSoundEffects();
    checkCardState();
    checkMatchesState();
    checkPettyState();
    checkMessageState();
    _getCurrentLocationSettings();
    refreshUser();
  }

  _getCurrentLocationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _currentLocation = PettySharedPref.getLocation(prefs);
    });
  }

  void updateSettingsApiCall() {
    SettingsUpdateApi settingsUpdateApi = new SettingsUpdateApi();
    settingsUpdateApi.settingsUpdate(settingsUpdateRequestModel).then((value) {
      if (value != null) {
        if (value.status != "success") {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      }
    });
  }

  void apiCall(int index) {
    loadDetails();
    if (index == 0) {
      FaqFetching faqFetching = new FaqFetching();
      faqFetching.Faq().then((value) {
        if (value != null) {
          if (value.status == "success") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FaqScreen(
                      data: value.data,
                    )));
          } else {
            final snackBar = SnackBar(
                content: Text(value.message),
                duration: const Duration(seconds: 1));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print(value.message);
          }
        }
      });
    } else {
      //cmsRequestModel.type = type;
      CmsFetching cmsFetching = new CmsFetching();
      cmsFetching.cmsGet(cmsRequestModel).then((value) {
        if (value != null) {
          if (value.status == "success") {
            print(value.message);
            content = value.data.content;
            caption = value.data.caption;

            // final snackBar = SnackBar(
            //     content: Text(value.message),
            //     duration: const Duration(seconds: 1));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CmsScreen(
                      type: type,
                      content: content,
                      caption: caption,
                    )));
          } else {
            final snackBar = SnackBar(
                content: Text(value.message),
                duration: const Duration(seconds: 1));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      });
    }
  }

  //final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 5, color: Color(0xffEDEDED)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoPremiumPkgs()));
                      },
                      child: SvgPicture.asset(
                        "assets/images/premium.svg",
                        width: 60,
                        height: 90,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            // builder: (_) => GetPettyPasses(),
                            builder: (_) => PettyPassScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/images/pettypass.svg",
                        width: 60,
                        height: 90,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SuperPettyScreen(),
                            // builder: (_) => GetSuperPetty(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/images/superpettyclr.svg",
                        width: 60,
                        height: 90,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 2, color: Color(0xffEDEDED)))),
                child: Text(
                  "SETTINGS",
                  style: TextStyle(
                      color: Color(0xffADACAC),
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 2, color: Color(0xffEDEDED)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Color(lightBlack),
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "My Current Location",
                              style: TextStyle(
                                  color: Color(lightBlack),
                                  fontFamily: "SFUIDisplay",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
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
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              buildAgeSlider(),
              Container(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 4, color: Color(0xffEDEDED)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show me in Cards",
                      style: TextStyle(
                          color: Color(lightBlack),
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Switch(
                        value: shwoMeInCard,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              settingsUpdateRequestModel.btnStatus = "1";
                              setCardState(value);
                            } else {
                              settingsUpdateRequestModel.btnStatus = "0";
                              setCardState(value);
                            }
                            shwoMeInCard = value;
                            print(shwoMeInCard);
                            settingsUpdateRequestModel.type = "1";
                          });
                          updateSettingsApiCall();
                        },
                        activeTrackColor: Color(0xffADACAC),
                        activeColor: Color(0xffED6963)),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 8, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 2, color: Color(0xffEDEDED)))),
                child: Text(
                  "PUSH NOTIFICATIONS",
                  style: TextStyle(
                      color: Color(0xffADACAC),
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffEDEDED)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Matches",
                      style: TextStyle(
                          color: Color(lightBlack),
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Switch(
                        value: newMatches,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              settingsUpdateRequestModel.btnStatus = "1";
                              setMatchesState(value);
                            } else {
                              settingsUpdateRequestModel.btnStatus = "0";
                              setMatchesState(value);
                            }
                            newMatches = value;
                            settingsUpdateRequestModel.type = "2";
                          });
                          updateSettingsApiCall();
                        },
                        activeTrackColor: Color(0xffADACAC),
                        activeColor: Color(0xffED6963)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 2, color: Color(0xffEDEDED)))),
              ),

              Container(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffEDEDED)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sound Effects",
                      style: TextStyle(
                          color: Color(lightBlack),
                          fontFamily: "SFUIDisplay",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Switch(
                        value: soundEffects,
                        onChanged: (value) async {
                          setState(() {
                            soundEffects = value;
                          });
                          setSoundEffects(soundEffects);
                        },
                        activeTrackColor: Color(0xffADACAC),
                        activeColor: Color(0xffED6963)),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 8, top: 14, bottom: 14),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xffEDEDED)))),
                  child: Text(
                    'Unblock User',
                    style: TextStyle(
                        color: Color(lightBlack),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                onTap: () {
                  // Get.to(UserDetailsScreen(
                  //   name: widget.user.name,
                  //   image: widget.user.image,
                  //   occupation: widget.user.occupation,
                  //   hobbies: widget.user.hobbies,
                  //   age: widget.user.age,
                  //   about: widget.user.about,
                  //   onPressed: () {
                  //                         Navigator.pop(context);
                  //                         _userBrowseService.swipedLeft(
                  //                             widget.index, widget.user);
                  //                       },
                  //                       userId: widget.user.id),
                  // );
                 

                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsScreen()));
                   Get.to(UnblockUser(settingsUpdateRequestModel.userId));
                },
              ),

              buildSettingList(),
              InkWell(
                splashColor: Color(pinkColor),
                onTap: () {
                  var dialog = DeleteAlertDialog(
                      title: "Delete Account",
                      message:
                          "Are you sure you want to delete your account permanently?",
                      onPostivePressed: () {},
                      positiveBtnText: "YES",
                      negativeBtnText: "NO");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 8, top: 14, bottom: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 4, color: Color(0xffEDEDED)))),
                  child: Text(
                    "Delete Account",
                    style: TextStyle(
                        color: Color(0xffFC0000),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
              // buildSettingList(),

              SizedBox(
                height: 30,
              ),

              // Center(
              //   child: Container(
              //     height: 50.0,
              //     child: RaisedButton(
              //       onPressed: () {
              //         _auth.signOut();
              //         Navigator.pushNamedAndRemoveUntil(
              //             context, '/wrapper', (context) => false);
              //       },
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50.0)),
              //       padding: EdgeInsets.all(0.0),
              //       child: Ink(
              //         decoration: BoxDecoration(
              //             gradient: LinearGradient(
              //               colors: [
              //                 Color(pinkColor),
              //                 Color(0xffFF5F5D),
              //               ],
              //
              //               begin: Alignment.topRight,
              //               end: Alignment.bottomLeft,
              //               //transform: GradientRotation(0.7853982),
              //             ),
              //             borderRadius: BorderRadius.circular(15.0)),
              //         child: Container(
              //           constraints: BoxConstraints(
              //               maxWidth: MediaQuery.of(context).size.width / 2,
              //               minHeight: 30.0),
              //           alignment: Alignment.center,
              //           child: Text(
              //             "Log Out",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //                 fontFamily: "SFUIDisplay",
              //                 fontSize: 20),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAgeSlider() {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2, color: Color(0xffEDEDED)))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Age text
              Text("Age",
                  style: TextStyle(
                      color: Color(lightBlack),
                      fontFamily: "SFUIDisplay",
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),

              Text(
                "${SettingPage.age.round()}",
                style: TextStyle(
                    color: Color(0xffADACAC),
                    fontFamily: "SFUIDisplay",
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
          FlutterSlider(
            values: [SettingPage.age],
            max: 99,
            min: 18,
            handlerHeight: 20,
            handlerWidth: 20,
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: Color(0xffED6963)),
              inactiveTrackBar: BoxDecoration(color: Colors.grey),
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                SettingPage.age = lowerValue;
              });
            },
            onDragStarted: (handlerIndex, lowerValue, upperValue) {
              isAgeDragging = true;
            },
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              UpdateAgeService.updateAge(lowerValue.toString());
            },
            handler: FlutterSliderHandler(
              foregroundDecoration: BoxDecoration(
                  color: Color(0xffED6963), shape: BoxShape.circle),
            ),
            rightHandler: FlutterSliderHandler(
              foregroundDecoration: BoxDecoration(
                  color: Color(0xffED6963), shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSettingList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: settingList.length,
      itemBuilder: (context, index) {
        return buildSettingItems(context, index);
      },
    );
  }

  Widget buildSettingItems(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 8, top: 14, bottom: 14),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xffEDEDED)))),
        child: Text(
          settingList[index].itemName,
          style: TextStyle(
              color: Color(lightBlack),
              fontFamily: "SFUIDisplay",
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
      onTap: () async {
        await callApi(index);
      },
    );
  }

  Future<void> callApi(int index) {
    isLoading = true;
    type = "$index";
    print("List type:" + type);
    apiCall(index);
    isLoading = false;
    // isLoading
    //     ? Center(
    //         child: CircularProgressIndicator(
    //         backgroundColor: Colors.black,
    //       ))
    //     : Navigator.of(context).push(MaterialPageRoute(
    //         builder: (context) => CmsScreen(
    //               type: type,
    //               content: content,
    //               caption: caption,
    //             )));
  }
}
