///other code

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/get_user_category.dart';
import 'package:petty_app/api/image_controller.dart';
import 'package:petty_app/api/my_profile/my_profile_api_service.dart';
import 'package:petty_app/api/my_profile/my_profile_data.dart';
import 'package:petty_app/api/petty_pass_activate_api.dart';
import 'package:petty_app/api/photo_list_api.dart';
import 'package:petty_app/models/image_list_response.dart';
import 'package:petty_app/screens/bottom_navigation/full_screen_photo_screen.dart';
import 'package:petty_app/screens/edit_profile_page.dart';
import 'package:petty_app/screens/main_bottom_page.dart';
import 'package:petty_app/screens/more_image_screen.dart';
import 'package:petty_app/screens/pettypass_screen.dart';
import 'package:petty_app/screens/superpetty_screen.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/delete_photo_api.dart';
import '../../models/delete_photo_model.dart';
import '../../provider/provider.dart';
import '../../utils/petty_shared_pref.dart';
import '../../widgets/choice_buttons.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/read_more.dart';

class NavProfile extends StatefulWidget {
  Function(bool) photoDeleted;
  NavProfile({Key key, this.photoDeleted}) : super(key: key);
  @override
  _NavProfileState createState() => _NavProfileState();
}

class _NavProfileState extends State<NavProfile> with TickerProviderStateMixin {
  DeletePhotoRequestModel deletePhotoRequestModel = DeletePhotoRequestModel();
  TabController _tabController;
  bool isLoadingCompleted = false;
  bool isVisible = false;
  int i = 0, pageNumber = 0;
  ScrollController _scrollController = new ScrollController();
  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    deletePhotoRequestModel.userId = _userId;
    String _token = PettySharedPref.getAccessToken(prefs);
    deletePhotoRequestModel.token = _token;
  }

  Future refreshUser() async {
    setState(() {
      getUserId();
    });
  }

  final ImageController imageController = Get.put(ImageController());
  bool isUploading = false;
  bool isLoading = false;
  var pid;
  bool circular = true;
  MyProfileData myProfileData = MyProfileData();
  List<Container> interestedDataContainers = [];

  @override
  void initState() {
    deletePhotoRequestModel = new DeletePhotoRequestModel(
      userId: "",
    );

    super.initState();
    //  _tabController = TabController(vsync: this, length: 2);
    refreshUser();
    //_tabController.addListener(() {
    setState(() {
      //  _tabController.index;
      // });
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
      }
    });

    // super.initState();
    apiCall();
    updateInterestedData();
  }

  void apiCall() async {
    MyProfile myProfile = new MyProfile();
    myProfile.getProfile().then((value) {
      if (value != null) {
        if (value.status == "success") {
          setState(() {
            myProfileData.userId = value.data.id != null ? value.data.id : '';
            myProfileData.name = value.data.name != null ? value.data.name : '';
            myProfileData.gender =
                value.data.gender != null ? value.data.gender : '';
            myProfileData.age = value.data.age != null ? value.data.age : '';
            myProfileData.location =
                value.data.location != null ? value.data.location : '';
            myProfileData.countrycode =
                value.data.countryCode != null ? value.data.countryCode : '';
            myProfileData.phone =
                value.data.phone != null ? value.data.phone : '';
            myProfileData.image =
                value.data.image != null ? value.data.image : '';
            myProfileData.occupation =
                value.data.occupation != null ? value.data.occupation : '';
            myProfileData.bio =
                value.data.biodata != null ? value.data.biodata : '';
            circular = false;
          });
        }
      }
    });
  }

  void pettyPassActivate() {
    PettyPassActivateApi passActivateApi = new PettyPassActivateApi();
    passActivateApi.passActivate().then((value) {
      if (value != null) {
        if (value.status == "success") {
          print(value.message);
          print(value.status);
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 3));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 3));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    TabController _tabController;
    var _controller;
    // final userData = Provider.of<UserData>(context);
    //final user = Provider.of<MyUser>(context);
    return
        // StreamBuilder<UserData>(
        // stream: DatabaseService(uid: user.uid).uData,
        // builder: (context, snapshot) {

        DefaultTabController(
      length: 2,
      child: Scaffold(
        body: circular
            ? Center(child: CircularProgressIndicator())
            : userDetails(),
      ),
    );
  }

  Widget userDetails() => SingleChildScrollView(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.14 + 200,
                //color: Colors.red,
                child: Stack(
                  children: [
                    //--------------------- MAIN PROFILE PICTURE --------------------//
                    Container(
                      height: MediaQuery.of(context).size.height / 2.3,
                      width: MediaQuery.of(context).size.width,
                      child: myProfileData.image != ""
                          ? CachedNetworkImage(
                              imageUrl: myProfileData.image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/user.png',
                            ),
                    ),
                    //--------------------- DISTANCE INFORMATION --------------------//
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height / 3.18,
                    //   left: 20,
                    //   child: Container(
                    //     padding: EdgeInsets.all(7),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.black54),
                    //     child: Row(
                    //       children: [
                    //         SvgPicture.asset(
                    //           'assets/images/locationsvg.svg',
                    //         ),
                    //         SizedBox(
                    //           width: 5,
                    //         ),
                    //         Text(
                    //           location,
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontFamily: "myfonts",
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 16),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.person_add,
                                color: Colors.white,
                                size: 30,
                              )),
                          Text(
                            myProfileData.name =
                                myProfileData.name.isNotEmpty &&
                                        myProfileData.name != null
                                    ? myProfileData.name[0].toUpperCase() +
                                        myProfileData.name.substring(1)
                                    : 'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SFUIDisplay",
                                //fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.white,
                                size: 30,
                              ))
                        ],
                      ),
                    ),

                    //--------------------- USER NAME DISPLAY SECTION --------------------//
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.8,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            myProfileData.name =
                                myProfileData.name.isNotEmpty &&
                                        myProfileData.name != null
                                    ? myProfileData.name[0].toUpperCase() +
                                        myProfileData.name.substring(1)
                                    : 'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          Text(
                            'Acrochat',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      // snapshot.hasData
                      //     ?
                      // Text(
                      //   snapshot.data.name,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontFamily: "SFUIDisplay",
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 22),
                      // )
                      //     :
                      //     Text(
                      //   myProfileData.name =
                      //       myProfileData.name[0].toUpperCase() +
                      //           myProfileData.name.substring(1),
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontFamily: "SFUIDisplay",
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 22),
                      // ),
                    ),
                    //--------------------- OCCUPATION DISPLAY SECTION --------------------//
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height / 2.4,
                    //   left: 20,
                    //   child:
                    //       // snapshot.hasData &&
                    //       //     snapshot.data.occupation != null
                    //       //     ? Text(
                    //       //   snapshot.data.occupation,
                    //       //   style: TextStyle(
                    //       //       color: Colors.white,
                    //       //       fontFamily: "myfonts",
                    //       //       fontWeight: FontWeight.bold,
                    //       //       fontSize: 15),
                    //       // )
                    //       //     :
                    //       myProfileData.occupation != "" &&
                    //               myProfileData.occupation != null
                    //           ? Text(
                    //               myProfileData.occupation,
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontFamily: "myfonts",
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15),
                    //             )
                    //           : Text(
                    //               "",
                    //               style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontFamily: "myfonts",
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 15),
                    //             ),
                    // ),
                    //--------------------- ICONS UPLOAD PICTURE VERTICAL --------------------//
                    Stack(
                      children: [
                        Positioned(
                          //top: MediaQuery.of(context).size.height / 2.6,
                          top: 300, left: 270,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.white,
                                backgroundImage: myProfileData.image != "" &&
                                        MainBottomPage.isConnected
                                    ? NetworkImage(myProfileData.image)
                                    : AssetImage("assets/images/user.png")),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 2.6,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditProfilePage(
                                            placeholderImage:
                                                myProfileData.image,
                                            placeholderBio: myProfileData.bio,
                                            placeholderName: myProfileData.name,
                                            placeholderOcc:
                                                myProfileData.occupation,
                                            changedPhotoUrl: (photoUrl) {
                                              setState(() {
                                                myProfileData.image = photoUrl;
                                              });
                                            },
                                          )))
                                  .then((value) {
                                setState(() {
                                  value;
                                });
                              });
                            },

                            //need change
                            //child:
                          ),
                        ),
                      ],
                    ),

                    //--------------------- PHONE, LOCATION, GENDER, HEIGHT SECTION STARTS HERE  --------------------//
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.15,
                      //left: 20,
                      //right: 20,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            //-----------------------------------UPDATE PHONE NUMBER ROW---------------------------//
                            SizedBox(
                              width: 7,
                            ),
                            myProfileData.phone != null
                                ? Text(
                                    myProfileData.phone,
                                    style: TextStyle(color: Color(0xff6D76AB)),
                                  )
                                : Text(
                                    "Number Not Entered",
                                    style: TextStyle(
                                        color: Color(0xff6D76AB), fontSize: 22),
                                  ),

                            SizedBox(
                              height: 10,
                            ),
                            //-----------------------------------UPDATE LOCATION ROW-------------------------------//
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    color: Color(0xff6D76AB),
                                    fontFamily: "myfonts",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // snapshot.hasData &&
                                //     snapshot.data.address !=
                                //         null &&
                                //     snapshot.data.address != ""
                                //     ?
                                InkWell(
                                    onTap: () async {
                                      // showAlertDialog(
                                      //   context,
                                      //   "Location",
                                      //   snapshot.data.uid,
                                      // );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          myProfileData.location,
                                          style: TextStyle(
                                            color: Color(0xff1E2661),
                                            fontFamily: "SFUIDisplay",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        // Text(
                                        //   "Memphis, US",
                                        //   // "${snapshot.data
                                        //   //     .city}, ${snapshot.data
                                        //   //     .country}",
                                        //   style: TextStyle(
                                        //     color: Color(0xff1E2661),
                                        //     fontFamily: "SFUIDisplay",
                                        //     fontWeight: FontWeight.w700,
                                        //   ),
                                        // )
                                      ],
                                    )),
                                // InkWell(
                                //     onTap: () async {
                                //       // showAlertDialog(
                                //       //   context,
                                //       //   "Location",
                                //       //   snapshot.data.uid,
                                //       // );
                                //     },
                                //     child: Column(
                                //       mainAxisAlignment:
                                //       MainAxisAlignment
                                //           .center,
                                //       crossAxisAlignment:
                                //       CrossAxisAlignment.end,
                                //       children: [
                                //         Text(
                                //           "CLICK TO UPATE,",
                                //           style: TextStyle(
                                //             color:
                                //             Color(0xff1E2661),
                                //             fontFamily:
                                //             "SFUIDisplay",
                                //             fontWeight:
                                //             FontWeight.w700,
                                //           ),
                                //         ),
                                //         Text(
                                //           "YOUR ADDRESS",
                                //           style: TextStyle(
                                //             color:
                                //             Color(0xff1E2661),
                                //             fontFamily:
                                //             "SFUIDisplay",
                                //             fontWeight:
                                //             FontWeight.w700,
                                //           ),
                                //         )
                                //       ],
                                //     ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //--------------------------_GENDER SECTION ------------------------------//
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gender",
                                  style: TextStyle(
                                    color: Color(0xff6D76AB),
                                    fontFamily: "myfonts",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // snapshot.hasData &&
                                //     snapshot.data.gender !=
                                //         null &&
                                //     snapshot.data.gender != ""
                                //     ? InkWell(
                                //     onTap: () async {
                                //       // showAlertDialog(
                                //       //   context,
                                //       //   "Gender",
                                //       //   snapshot.data.uid,
                                //       // );
                                //     },
                                //     child: Text(
                                //       //snapshot.data.gender,
                                //       style: TextStyle(
                                //         color: Color(0xff1E2661),
                                //         fontFamily: "SFUIDisplay",
                                //         fontWeight:
                                //         FontWeight.w700,
                                //       ),
                                //     ))
                                //:
                                InkWell(
                                  onTap: () {
                                    // showAlertDialog(
                                    //   context,
                                    //   "Gender",
                                    //   //snapshot.data.uid,
                                    // );
                                  },
                                  child: Text(
                                    myProfileData.gender =
                                        myProfileData.gender[0].toUpperCase() +
                                            myProfileData.gender.substring(1),
                                    style: TextStyle(
                                      color: Color(0xff1E2661),
                                      fontFamily: "SFUIDisplay",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: 15,
                            ), //--------------------------HEIGHT SECTION ------------------------------//
                            Text(
                              'About',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            ReadMoreText(
                              text: myProfileData.bio =
                                  myProfileData.bio.isNotEmpty &&
                                          myProfileData.bio != null
                                      ? myProfileData.bio[0].toUpperCase() +
                                          myProfileData.bio.substring(1)
                                      : 'Phone Number',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ReadMoreText(text:myProfileData.bio != null
                            //     ? Text(
                            //         myProfileData.bio,
                            //         style: TextStyle(
                            //           color: Color(0xff6D76AB),
                            //           fontFamily: "myfonts",
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //----------------------------   Intrest SECTION -----------------------------------?

              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Interested",
                          style: TextStyle(
                              color: Color(0xff1E2661),
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: interestedDataContainers,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Photos'),
                    TextButton(
                      onPressed: () async {
                        Get.bottomSheet(
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0)),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Camera'),
                                  onTap: () async {
                                    Get.back();
                                    await imageController.uploadImage(
                                        ImageSource.camera, false);
                                    setState(() {});
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text('Gallery'),
                                  onTap: () async {
                                    Get.back();
                                    await imageController.uploadImage(
                                        ImageSource.gallery, false,
                                        isMultiple: true);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text('Uploaded Photos'),
                    ),

                    // Text('Uploaded Photos'),
                  ],
                ),
              ),

              TabBar(
                labelColor: Color(0xffFF4181),
                unselectedLabelColor: Colors.grey,

                // labelColor: Color(0xffFF4181),
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xffFF4181),
                //  unselectedLabelColor: Color(0xffFF4181),

                //  controller: _controller,
                tabs: [
                  Tab(
                    icon: ImageIcon(
                      AssetImage('assets/images/photos.png'),
                      size: 24,
                    ),
                  ),
                  Tab(
                    icon: ImageIcon(
                      AssetImage('assets/images/uploaded_photos.png'),
                      size: 24,
                    ),
                  ),
                ],
              ),

              Container(
                height: 200,
                width: double.infinity,
                child: TabBarView(
                  // controller: _controller,
                  children: <Widget>[
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: FutureBuilder<List<ImageData>>(
                        future: PhotoListApiService()
                            .fetchPhotoList(pageNumber: pageNumber),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting &&
                              !isLoadingCompleted) {
                            isLoadingCompleted = true;
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return GridView.custom(
                              gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 12,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                pattern: [
                                  QuiltedGridTile(6, 6),
                                  QuiltedGridTile(6, 6),
                                  QuiltedGridTile(5, 4),
                                  QuiltedGridTile(5, 4),
                                  QuiltedGridTile(5, 4),
                                  // QuiltedGridTile(1, 1),
                                ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      setState(() {
                                        isVisible = true;
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FullScreenPhotoPage(
                                                    snapshot.data[index].img),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    deletePhotoRequestModel
                                                            .photoId =
                                                        snapshot
                                                            .data[index].imgId;
                                                  });
                                                  //_showDialog();
                                                  deletePhotoApiCall();
                                                },
                                                child: Visibility(
                                                  visible: isVisible,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.redAccent,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          image: new DecorationImage(
                                              image: new NetworkImage(
                                                  snapshot.data[index].img),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: snapshot.data.length,
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: FutureBuilder<List<ImageData>>(
                        future: PhotoListApiService()
                            .fetchPhotoList(pageNumber: pageNumber),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting &&
                              !isLoadingCompleted) {
                            isLoadingCompleted = true;
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            return GridView.custom(
                              gridDelegate: SliverQuiltedGridDelegate(
                                crossAxisCount: 12,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                pattern: [
                                  QuiltedGridTile(6, 6),
                                  QuiltedGridTile(6, 6),
                                  QuiltedGridTile(5, 4),
                                  QuiltedGridTile(5, 4),
                                  QuiltedGridTile(5, 4),
                                  // QuiltedGridTile(1, 1),
                                ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return InkWell(
                                    onLongPress: () {
                                      setState(() {
                                        isVisible = true;
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FullScreenPhotoPage(
                                                    snapshot.data[index].img),
                                          ),
                                        );
                                      },
                                      child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      deletePhotoRequestModel
                                                              .photoId =
                                                          snapshot.data[index]
                                                              .imgId;
                                                    });
                                                    //_showDialog();
                                                    deletePhotoApiCall();
                                                  },
                                                  child: Visibility(
                                                    visible: isVisible,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.redAccent,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              image: new DecorationImage(
                                                  image: new NetworkImage(
                                                      snapshot.data[index].img),
                                                  fit: BoxFit.cover))),
                                    ),
                                  );
                                },
                                childCount: snapshot.data.length,
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      ),

                      //
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'See All',
                  style: TextStyle(color: Color(0xffFF4181)),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              CustomContainer(
                img: "assets/images/premium.svg",
                txt1: 'Get Premiuim',
                txt2:
                    'Be the top profile in your area for the next 30 minutes and get more matches.',
              ),

              CustomContainer(
                img: "assets/images/premium.svg",
                txt1: 'Petty Pass',
                txt2:
                    'Be the top profile in your area for the next 30 minutes and get more matches.',
              ),

              CustomContainer(
                img: "assets/images/pettypass.svg",
                txt1: 'Sure Petty',
                txt2:
                    'Be the top profile in your area for the next 30 minutes and get more matches.',
              ),
              SizedBox(
                height: 10,
              ),

//changed

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  void deletePhotoApiCall() {
    DeletePhotoApi deletePhotoApi = new DeletePhotoApi();
    deletePhotoApi.deletePhoto(deletePhotoRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          widget.photoDeleted(true);
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

  updateInterestedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categories = PettySharedPref.getSelectedSubcategoryList(prefs);
    if (categories == null || categories.isEmpty) {
      print("catgories is empty");
      GetUserCategory getUserCategory = GetUserCategory();
      categories = await getUserCategory.userCategory();
    }
    if (categories != null && categories.isNotEmpty) {
      for (String i in categories) {
        interestedDataContainers.add(
          Container(
            margin: EdgeInsets.only(bottom: 10, right: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              i,
              style: TextStyle(
                color: Color(0xff1E2661),
                fontFamily: "SFUIDisplay",
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }
    setState(() {});
  }

  showAlertDialog(BuildContext context, String parameter, String userid) {
    TextEditingController _address = TextEditingController();
    TextEditingController _city = TextEditingController();
    TextEditingController _country = TextEditingController();
    TextEditingController _controller = TextEditingController();

    // final DatabaseService _database = DatabaseService(uid: userid);
    // Create button
    // Widget okButton = FlatButton(
    // child: Text("Submit"),
    // onPressed: () async {
    //  if (parameter == "Phone No") {
    //   await Firestore.instance
    //      .collection("userData")
    //     .document(userid)
    //    .updateData({'phone': _controller.text});
    // }
    // if (parameter == "Location") {
    //   await Firestore.instance
    //      .collection("userData")
    //      .document(userid)
    //      .updateData(
    //   {
    //      'address': _address.text,
    //     "city": _city.text,
    //     "country": _country.text,
    //  },
    // );
    // }
    // if (parameter == "Gender") {
    //await Firestore.instance
    //     .collection("userData")
    //  .document(userid)
    //    .updateData({'gender': _controller.text});
    // }
    // if (parameter == "Height") {
    // await Firestore.instance
    // .collection("userData")
    // .document(userid)
    //  .updateData({'height': _controller.text});
    //}
    // if (parameter == "Bio Data") {
    //await Firestore.instance
    //    .collection("userData")
    //   .document(userid)
    //   .updateData({'bioData': _controller.text});
    //}

    //Navigator.of(context).pop();
    //},
    // );

    Widget cButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancel"));
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update $parameter"),
      content: parameter != "Location"
          ? TextFormField(
              decoration: InputDecoration(
                hintText: parameter == "Height"
                    ? "Height in ft.inches (6.0\")"
                    : parameter,
              ),
              controller: _controller,
              maxLines: parameter == "Bio Data" ? 6 : 1,
            )
          : Container(
              height:
                  200, //MediaQuery.of(context).size.height * 0.50, //400, //
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Address Line",
                    ),
                    maxLines: 2,
                    controller: _address,
                  ),
                  TextFormField(
                    // initialValue: "City",
                    decoration: InputDecoration(hintText: "City"),
                    controller: _city,
                  ),
                  TextFormField(
                    // initialValue: "Country",
                    decoration: InputDecoration(hintText: "Country"),
                    controller: _country,
                  )
                ],
              ),
            ),
      actions: [
        cButton,
        //okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
