import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petty_app/api/image_controller.dart';

import '../utils/constant.dart';
import 'category/category_page.dart';
import 'constants.dart';

class InitialPhotoPage extends StatefulWidget {
  @override
  _InitialPhotoPageState createState() => _InitialPhotoPageState();
}

class _InitialPhotoPageState extends State<InitialPhotoPage> {
  final ImageController imageController = Get.put(ImageController());
  String imageSource;
  bool isLoading = false;

  showImage() {
    var image = imageSource == null || imageSource.isEmpty
        ? Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/add_photo.svg',
                  height: 150.0,
                  width: 150.0,
                ),
              ),
              isLoading
                  ? Center(
                      child: SizedBox(
                        child: Center(child: CircularProgressIndicator()),
                        height: 150.0,
                        width: 150.0,
                      ),
                    )
                  : SizedBox(),
            ],
          )
        : Image.file(
            File(imageSource),
            width: 150.0,
            height: 150.0,
          );
    return image;
  }

  imageUpload(ImageSource image) async {
    setState(() {
      isLoading = true;
    });
    imageSource = await imageController.uploadImage(image, true);
    setState(() {
      imageSource;
      isLoading = false;
    });
    print('setstate called $imageSource');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: DottedBorder(
                color: Color(0xffF7A9AE),
                dashPattern: [8, 4],
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: Radius.circular(30.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      showImage(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Add a photo to get\nstarted!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
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
                                    onTap: () {
                                      Get.back();

                                      imageUpload(ImageSource.camera);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text('Gallery'),
                                    onTap: () {
                                      Get.back();
                                      imageUpload(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffff4f5D)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            imageSource == null || imageSource.isEmpty
                                ? "ADD PHOTO"
                                : 'CHANGE PHOTO',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: imageSource != null && imageSource.isNotEmpty,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 35.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (imageSource != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Category(), //Category(),
                            ));
                      }
                    },
                    style: kNextButtonStyle,
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(pinkColor),
                              Color(0xffFF5F5D),
                            ],

                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            //transform: GradientRotation(0.7853982),
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 3,
                            minHeight: 30.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SFUIDisplay",
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
