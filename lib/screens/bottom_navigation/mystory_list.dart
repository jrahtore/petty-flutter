import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/delete_story_api.dart';
import 'package:petty_app/api/my_story_list_api.dart';
import 'package:petty_app/api/story_controller.dart';
import 'package:petty_app/models/delete_story_response.dart';
import 'package:petty_app/models/profile.dart';
import 'package:petty_app/screens/StoryViewScreen.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStoryListPage extends StatefulWidget {
  final Profile profile;
  const MyStoryListPage({Key key, this.profile}) : super(key: key);

  @override
  _MyStoryListPageState createState() => _MyStoryListPageState();
}

class _MyStoryListPageState extends State<MyStoryListPage> {
  final StoryController storyController = Get.put(StoryController());
  DeleteStoryRequestModel deleteStoryRequestModel = DeleteStoryRequestModel();

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    deleteStoryRequestModel.userId = _userId;
    String _token = PettySharedPref.getAccessToken(prefs);
    deleteStoryRequestModel.token = _token;
  }

  Future refreshUser() async {
    setState(() {
      getUserId();
    });
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    refreshUser();
    // setState(() {
    //   const oneSecond = const Duration(seconds: 2);
    //   new Timer.periodic(oneSecond, (Timer t) => setState(() {}));
    // });
  }

  void deleteStoryApiCall() {
    DeleteStoryApi deleteStoryApi = new DeleteStoryApi();
    deleteStoryApi.deleteStory(deleteStoryRequestModel).then((value) {
      if (value != null) {
        if (value.status == "success") {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      floatingActionButton: FloatingActionButton(
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
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Story",
                      style: TextStyle(
                          color: Color(0xff1E2661),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: () async {
                      Get.back();
                      await storyController.uploadStory(ImageSource.camera);
                      setState(() {});
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () async {
                      Get.back();
                      await storyController.uploadStory(ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xff1E2661),
        highlightElevation: 20,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff1E2661), //change your color here
        ),
        centerTitle: true,
        title: Text(
          "My Story",
          style: TextStyle(
              color: Color(0xff1E2661),
              fontFamily: "SFUIDisplay",
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " * Your stories will disappear after 24h",
                    style: TextStyle(
                        color: Color(0xff1E2661),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: FutureBuilder<Map>(
                        future: MyStoryListApiService().fetchMyStory(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return Center(
                              child: Text(
                                "No Stories found !",
                                style: TextStyle(color: Colors.pink, fontSize: 18),
                              ),
                            );
                          } else {
                            List pics = snapshot.data['data']['pics'];
                            return ListView.builder(
                                itemCount: pics.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10, left: 20),
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoryPageView(
                                                            storyLinks: [
                                                              pics[index]
                                                            ],
                                                            storyText: "",
                                                          ))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(40)),
                                                  border: Border.all(
                                                      color: Colors.green[300],
                                                      width: 3),
                                                ),
                                                child: widget.profile.image == null
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/user.png"))
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        backgroundImage:
                                                            NetworkImage(widget
                                                                .profile.image)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 20.0),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    deleteStoryRequestModel
                                                            .storyId =
                                                        snapshot.data['data']
                                                                [index.toString()]
                                                                ['story_id']
                                                            .toString();
                                                  });
                                                  deleteStoryApiCall();
                                                },
                                                child: Icon(
                                                  Icons.delete_rounded,
                                                  size: 35,
                                                  color: Colors.red[300],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        }),
                  )
                ],
              ),
            ),
            Center(child: storyController.isLoading.value?CircularProgressIndicator():SizedBox(),)
          ],
        ),
      ),
    );
  }
}
