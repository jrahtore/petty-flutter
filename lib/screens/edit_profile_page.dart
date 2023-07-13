import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/profile_pic_controller.dart';
import 'package:petty_app/api/profile_update_api.dart';
import 'package:petty_app/models/profile_update_model.dart';
import 'package:petty_app/screens/bottom_navigation/nav_profile.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String placeholderName;
  final String placeholderOcc;
  final String placeholderBio;
  final String placeholderImage;
  final Function(String changedPhotoUrl) changedPhotoUrl;

  EditProfilePage(
      {Key key,
      this.placeholderImage,
      this.placeholderBio,
      this.placeholderName,
      this.placeholderOcc,
      this.changedPhotoUrl})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileUpdateRequestModel profileUpdateRequestModel =
      ProfileUpdateRequestModel();
  final nameController = new TextEditingController();
  final occController = new TextEditingController();
  final bioController = new TextEditingController();
  // bool isNameInValid = false;
  // bool isOccInValid = false;
  // bool isBioInValid = false;
  final ProfilePicController profilePicController =
      Get.put(ProfilePicController());

  Future refreshUser() async {
    setState(() {
      getUserId();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    occController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = PettySharedPref.getUserId(prefs);
    profileUpdateRequestModel.userId = _userId;
    String _token = PettySharedPref.getAccessToken(prefs);
    profileUpdateRequestModel.token = _token;
    profileUpdateRequestModel.type = 'details';

    // profileUpdateRequestModel.name = widget.placeholderName;
    // profileUpdateRequestModel.occupation = widget.placeholderOcc;
    // profileUpdateRequestModel.biodata = widget.placeholderBio;
  }

  void initState() {
    profileUpdateRequestModel = new ProfileUpdateRequestModel(
        userId: "", biodata: "", occupation: "", name: "", token: "", type: "");

    super.initState();
    refreshUser();
  }

  void apiCall() {
    ProfileUpdateApi profileUpdateApi = new ProfileUpdateApi();
    profileUpdateApi.updateProfile(profileUpdateRequestModel).then((value) {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff1E2661), //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff1E2661)),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop('String');
          return false;
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Obx(() {
                            if (profilePicController.isLoading.value) {
                              return CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )),
                              );
                            } else {
                              if (profilePicController.imageURL.length != 0) {
                                return CachedNetworkImage(
                                  imageUrl: profilePicController.imageURL,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                );
                              } else {
                                return widget.placeholderImage == ""
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: AssetImage(
                                            'assets/images/user.png'),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            widget.placeholderImage),
                                      );
                              }
                            }
                          }),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
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
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.camera),
                                            title: Text('Camera'),
                                            onTap: () async {
                                              Get.back();
                                              String image =
                                                  await profilePicController
                                                      .uploadProfileImage(
                                                          ImageSource.camera);
                                              widget.changedPhotoUrl(image);
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text('Gallery'),
                                            onTap: () async {
                                              Get.back();
                                              String image =
                                                  await profilePicController
                                                      .uploadProfileImage(
                                                          ImageSource.gallery);
                                              widget.changedPhotoUrl(image);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.red[300],
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: nameController,
                    //  onSubmitted: (input) => profileUpdateRequestModel.name = input,
                    decoration: InputDecoration(
                      //    errorText: isNameInValid ? "Please Enter Name" : "",
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Full Name",
                      hintText: widget.placeholderName,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1E2661),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: occController,

                    //onSubmitted: (input) => profileUpdateRequestModel.occupation = input,
                    decoration: InputDecoration(
                        //  errorText: isOccInValid ? "Please Enter Ocuupation" : "",
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Occupation",
                        hintText: widget.placeholderOcc,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1E2661),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: bioController,
                    //onSubmitted: (input) => profileUpdateRequestModel.biodata = input,
                    decoration: InputDecoration(
                      // errorText: isBioInValid ? "Please Enter Bio" : "",
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Bio",
                      hintText: widget.placeholderBio,
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1E2661),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (bioController.text.isEmpty) {
                            profileUpdateRequestModel.biodata =
                                widget.placeholderBio;
                          } else {
                            profileUpdateRequestModel.biodata =
                                bioController.text;
                          }
                          if (nameController.text.isEmpty) {
                            profileUpdateRequestModel.name =
                                widget.placeholderName;
                          } else {
                            profileUpdateRequestModel.name =
                                nameController.text;
                          }
                          if (occController.text.isEmpty) {
                            profileUpdateRequestModel.occupation =
                                widget.placeholderOcc;
                          } else {
                            profileUpdateRequestModel.occupation =
                                occController.text;
                          }
                        });
                        apiCall();

                        bioController.clear();
                        occController.clear();
                        nameController.clear();

                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NavProfile()))
                            .then((value) => setState(() => {}));
                        ;
                      },
                      // color: Color(0xff1E2661),
                      // padding: EdgeInsets.symmetric(horizontal: 50),
                      // elevation: 2,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
