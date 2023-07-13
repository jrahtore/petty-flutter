import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/api/delete_photo_api.dart';
import 'package:petty_app/api/photo_list_api.dart';
import 'package:petty_app/models/delete_photo_model.dart';
import 'package:petty_app/models/image_list_response.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/full_screen_photo_screen.dart';

class MoreImageScreen extends StatefulWidget {
  Function(bool) photoDeleted;
  MoreImageScreen({Key key, this.photoDeleted}) : super(key: key);

  @override
  State<MoreImageScreen> createState() => _MoreImageScreenState();
}

class _MoreImageScreenState extends State<MoreImageScreen>
    with TickerProviderStateMixin {
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

  @override
  void initState() {
    deletePhotoRequestModel = new DeletePhotoRequestModel(
      userId: "",
    );

    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    refreshUser();
    _tabController.addListener(() {
      setState(() {
        _tabController.index;
      });
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: Platform.isAndroid ? false : true,
        // title: Text(
        //   "All Photos",
        //   style: TextStyle(
        //       color: Color(0xff1E2661),
        //       fontFamily: "SFUIDisplay",
        //       fontWeight: FontWeight.bold,
        //       fontSize: 25),
        // ),
        iconTheme: IconThemeData(color: Color(0xff1E2661)),
        elevation: 1,
        backgroundColor: Colors.white,
        bottom:
         TabBar(
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xffed417d),
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Tab(
                icon: SvgPicture.asset(
                  'assets/box.svg',
                  height: 20,
                  width: 20,
                  color: _tabController.index == 0
                      ? Color(0xffed417d)
                      : Color(0xffa9a9a9),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Tab(
                icon: SvgPicture.asset(
                  'assets/list.svg',
                  color: _tabController.index == 1
                      ? Color(0xffed417d)
                      : Color(0xffa9a9a9),
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
            child: Center(
              child:
               FutureBuilder<List<ImageData>>(
                future: PhotoListApiService()
                    .fetchPhotoList(pageNumber: pageNumber),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              deletePhotoRequestModel.photoId =
                                                  snapshot.data[index].imgId;
                                            });
                                            //_showDialog();
                                            deletePhotoApiCall();
                                          },
                                          child: Visibility(
                                            visible: isVisible,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 1, right: 1),
            child: Center(
              child: 
              FutureBuilder<List<ImageData>>(
                future: PhotoListApiService()
                    .fetchPhotoList(pageNumber: pageNumber),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.all(2),
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
                                child: InkWell(
                                  onLongPress: () {
                                    setState(() {
                                      isVisible = true;
                                    });
                                  },
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                deletePhotoRequestModel
                                                        .photoId =
                                                    snapshot.data[index].imgId;
                                              });
                                              //_showDialog();
                                              deletePhotoApiCall();
                                            },
                                            child: Visibility(
                                              visible: isVisible,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
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
                              ));
                        });
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }

  // Future<void> _showDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, //this means the user must tap a button to exit the Alert Dialog
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10)),
  //         title: Text('Delete Photo'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Do you want to delete this photo ?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           FlatButton(
  //             child:Text("NO",
  //                 style: TextStyle(fontWeight: FontWeight.bold)),
  //             textColor: Colors.black,
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           FlatButton(
  //             child:Text("YES",
  //         style: TextStyle(fontWeight: FontWeight.bold)),
  //             textColor: Color(pinkColor),
  //             onPressed: () {
  //               deletePhotoApiCall();
  //
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
