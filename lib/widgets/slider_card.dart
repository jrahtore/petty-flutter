import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:get/get.dart';
import 'package:petty_app/api/gift_api.dart';
import 'package:petty_app/api/rewind_api.dart';
import 'package:petty_app/component/matchesdailogue.dart';
import 'package:petty_app/models/gift_model.dart';
import 'package:petty_app/models/match_add_model.dart';
import 'package:petty_app/models/slider_list_response.dart';
import 'package:petty_app/screens/go_premium_pkgs.dart';
import 'package:petty_app/screens/user_detail_screen/user_detail_screen.dart';
import 'package:petty_app/services/user_browse_service.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/superpetty_api.dart';
import '../component/gift_dialog.dart';
import '../screens/bioscreen.dart';
import '../screens/packeges.dart';
import 'alert_dialogue.dart';

class SliderCard extends StatefulWidget {
  final SliderListResponse user;
  final int index;
  const SliderCard({this.user, this.index, Key key}) : super(key: key);

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  String imagePathHeart = "assets/images/heartsvg.svg";
  String imagePathCross = "assets/images/crosssvg.svg";
  UserBrowseService _userBrowseService = UserBrowseService();
  MatchAddRequestModel matchAddRequestModel = MatchAddRequestModel();
  bool isSuperPettySent = false;
  int photoListSize = 1, shownPhotoNumber = 0;
  bool isGiftButtonEnabled = true;

  Future refreshUser() async {
    setState(() {
      getUserId();
    });
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    matchAddRequestModel.userId = _userId;
    String _token = PettySharedPref.getAccessToken(prefs);
    matchAddRequestModel.token = _token;
    matchAddRequestModel.userLikeId = widget.user.id;
  }

  void initState() {
    super.initState();
    matchAddRequestModel = new MatchAddRequestModel(
      userId: "",
    );

    if (!widget.user.photos.contains(widget.user.image)) {
      widget.user.photos.insert(0, widget.user.image);
    }
    photoListSize = widget.user.photos.length;
    refreshUser();
  }

  void rewindStatusApi() {
    RewindApi rewindApi = new RewindApi();
    rewindApi.rewind().then((value) {
      if (value != null) {
        if (value.status == "success") {
          // NavHome.data.add(NavHome.selectedData.last);
          _userBrowseService.rewindCard();
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Packages(),
                //welcomepage
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeDown: (finalPosition) {},
      onSwipeUp: (finalPosition) {},
      onSwipeLeft: (finalPosition) {
        _userBrowseService.swipedLeft(widget.index, widget.user);
      },
      onSwipeRight: (finalPosition) {
        UserBrowseService().swipedRight(widget.index, widget.user);
      },
      onPositionChanged: (details) {},
      onSwipeStart: (details) {},
      onSwipeCancel: (position, details) {},
      onSwipeEnd: (position, details) {},
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;
          // print('');
          return Container(
            width: maxWidth,
            height: maxHeight,
            child: widget.user != null
                ? Card(
                    shape: RoundedRectangleBorder(
                      side: widget.user.superPettyStatus == 1
                          ? BorderSide(color: Colors.green, width: 10.0)
                          : BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 200,
                            color: Colors.black54,
                          ),
                          CachedNetworkImage(
                            imageUrl: widget.user.photos.length > 0
                                ? widget.user.photos[shownPhotoNumber]
                                : widget.user.image,
                            imageBuilder: (context, imageProvider) => Container(
                              // padding: EdgeInsets.only(top: 78),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (shownPhotoNumber > 0) {
                                            shownPhotoNumber--;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (shownPhotoNumber <
                                              photoListSize - 1) {
                                            shownPhotoNumber++;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Positioned(
                            top: 40,
                            left: 20,
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // showAlertDialog(
                                  //   context,
                                  // );
                                  Get.to(
                                    UserDetailsScreen(
                                        name: widget.user.name,
                                        image: widget.user.image,
                                        occupation: widget.user.occupation,
                                        hobbies: widget.user.hobbies,
                                        age: widget.user.age,
                                        about: widget.user.about,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _userBrowseService.swipedLeft(
                                              widget.index, widget.user);
                                        },
                                        userId: widget.user.id),
                                  );
                                },
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showAlertDialog(
                                          context,
                                        );
                                      },
                                      child: Text(
                                        widget.user.name =
                                            widget.user.name[0].toUpperCase() +
                                                widget.user.name.substring(1),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "SFUIDisplay",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                    Text(
                                      widget.user.occupation ?? '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "myfonts",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 48,
                            right: 20,
                            child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/locationsvg.svg',
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),

                                  /// user distance
                                  /// widget.user.distance converted to .tostring as it was causing error
                                  Text(
                                    widget.user.distance.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "myfonts",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 20,
                            right: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // _showToast("assets/images/crossanimate.png",0);
                                    rewindStatusApi();
                                    // cardController.triggerLeft();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/refreshsvg.svg',
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      imagePathCross =
                                          "assets/images/crossanim.svg";
                                    });
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      _userBrowseService.swipedLeft(
                                          widget.index, widget.user);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      imagePathCross,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: isGiftButtonEnabled
                                      ? () async {
                                          isGiftButtonEnabled = false;
                                          final GiftModel giftModel =
                                              await GiftApi().giftsGet();
                                          if (true) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GiftDialogBox(
                                                      giftModel);
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return DriveDialogBox();
                                                });
                                          }
                                          isGiftButtonEnabled = true;
                                        }
                                      : null,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/giftboxsvg.svg',
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      imagePathHeart =
                                          "assets/images/heartanimated.svg";
                                    });
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      UserBrowseService().swipedRight(
                                          widget.index, widget.user);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      imagePathHeart,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isSuperPettySent = true;
                                    });
                                    final response =
                                        await SuperPettyActivateApi()
                                            .superPettyActivate(widget.user.id);
                                    if (response['status'] == 'success') {
                                      _userBrowseService.swipedRight(
                                          widget.index, widget.user);
                                    } else if (response['status'] == 'error') {
                                      setState(() {
                                        isSuperPettySent = false;
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GoPremiumPkgs(),
                                          //welcomepage
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/starsvg.svg',
                                      color: isSuperPettySent == true
                                          ? Colors.orange
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 90,
                            left: 0,
                            right: 0.0,
                            child: SizedBox(
                              child: Container(
                                height: 20,
                                child: buildPettiesList(),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 120,
                            // left: 200,
                            // right: 0,
                            // left: MediaQuery.of(context).size.width / 3.3,
                            child: Container(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFF1C7E),
                                      Color(0xffFF5F5D),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    //transform: GradientRotation(0.7853982),
                                  ),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Text(
                                  "\" I'm Petty About \"",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: "SFUIDisplay",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,

                            // bottom: 100,
                            //left: MediaQuery.of(context).size.width / 2.3,
                            child: Visibility(
                              visible:
                                  widget.user.photos.length > 1 ? true : false,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: Colors.black54,
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                      widget.user.photos.length > 0
                                          ? min(widget.user.photos.length, 6)
                                          : 1,
                                      (index) => Padding(
                                        padding: EdgeInsets.only(
                                            left: index == 0 ? 0 : 5),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 4),
                                          height: 6,
                                          width: 6,
                                          decoration: BoxDecoration(
                                            color: shownPhotoNumber == index
                                                ? Colors.white
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //     margin: EdgeInsets.only(left: 4),
                                    //     height: 6,
                                    //     width: 6,
                                    //     decoration: BoxDecoration(
                                    //         color: shownPhotoNumber == 0
                                    //             ? Colors.white
                                    //             : Colors.grey,
                                    //         borderRadius: BorderRadius.circular(5))),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //     margin: EdgeInsets.only(left: 4),
                                    //     height: 6,
                                    //     width: 6,
                                    //     decoration: BoxDecoration(
                                    //         color: shownPhotoNumber == 1
                                    //             ? Colors.white
                                    //             : Colors.grey,
                                    //         borderRadius: BorderRadius.circular(5))),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //     margin: EdgeInsets.only(left: 4),
                                    //     height: 6,
                                    //     width: 6,
                                    //     decoration: BoxDecoration(
                                    //         color: shownPhotoNumber >= 2
                                    //             ? Colors.white
                                    //             : Colors.grey,
                                    //         borderRadius: BorderRadius.circular(5))),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.only(left: 4),
                                    //   height: 6,
                                    //   width: 6,
                                    //   decoration: BoxDecoration(
                                    //     color: shownPhotoNumber >= 3
                                    //         ? Colors.white
                                    //         : Colors.grey,
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          );

          //   Container(
          //   padding: EdgeInsets.all(12),
          //   height: maxHeight,
          //   width: maxWidth,
          //   color: Colors.blueGrey.withOpacity(0.3),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         height: 140,
          //         width: 140,
          //         child: CircleAvatar(
          //           backgroundImage: NetworkImage(user.image),
          //         ),
          //       ),
          //       SizedBox(height: 24),
          //       Text(
          //         '${user.name}, (${user.gender.toUpperCase()[0]})',
          //         style: TextStyle(
          //           fontWeight: FontWeight.w600,
          //           fontSize: 18,
          //           letterSpacing: 0.5,
          //         ),
          //       ),
          //       SizedBox(height: 8),
          //
          //     ],
          //   ),
          // );
        },
      ),
    );
  }

  Widget buildPettiesList() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.user?.subcategoryNames?.length ?? 0,
      itemBuilder: (context, index) {
        return buildPettiesItems(context, index);
      },
    );
  }

  Widget buildPettiesItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        !widget.user.payment_type.toString().contains('premium') ?? true
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DriveDialogBox();
                })
            : null;
      },
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        margin: EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: Color(0xff6D76AB),
          //color: Colors.red,

          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          children: [
            Text(
              widget.user?.payment_type?.toString()?.contains('premium') ??
                      false
                  ? widget.user?.subcategoryNames?.elementAt(index) ??
                      "Unlock Now"
                  : "Unlock Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            SizedBox(
              width: widget.user?.subcategoryNames == null ? 2 : 0,
            ),
            widget.user?.subcategoryNames == null
                ? Image.asset(
                    "assets/images/lock.png",
                    scale: 1.3,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
