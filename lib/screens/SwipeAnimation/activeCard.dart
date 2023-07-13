import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petty_app/screens//SwipeAnimation/detail.dart';

Positioned cardDemo(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  bool cross = false;

  return new Positioned(
    //bottom: 0.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    // left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
      crossAxisEndOffset: -0.2,
      onResize: () {
        //print("here");
        // setState(() {
        //   var i = data.removeLast();

        //   data.insert(0, i);
        // });
      },
      onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
        if (direction == DismissDirection.endToStart)
          dismissImg(img);
        else
          addImg(img);
      },
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: new Hero(
              tag: "img",
              child: new GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) => new DetailPage(type: img)));
                  Navigator.of(context).push(new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new DetailPage(type: img),
                  ));
                },
                child: Card(
                  //color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //color: Colors.red,
                  child: Stack(
                    children: [
                      // Container(
                      //   // padding: EdgeInsets.only(top: 78),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25),
                      //     image: DecorationImage(
                      //         image: AssetImage(
                      //           'assets/gary.png',
                      //         ),
                      //         fit: BoxFit.cover),
                      //   ),
                      // ),
                      new Container(
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: img,
                        ),
                      ),
                      Positioned(
                          top: 200,
                          left: MediaQuery.of(context).size.width / 3,
                          child: Image.asset("assets/images/crossanimate.png")
                          //_likeOrDislikeIconOnPhoto(FontAwesomeIcons.ban,Colors.redAccent)

                          ),

                      Positioned(
                        top: 40,
                        left: 20,
                        child: Text(
                          "Gary",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 20,
                        child: Text(
                          "Gamer",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "myfonts",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Positioned(
                        top: 48,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white12,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/locationsvg.svg',
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "3 miles",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "myfonts",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
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
                                // _showToast("assets/images/crossanimate.png");
                                // cardController.triggerLeft();
                              },
                              child: SvgPicture.asset(
                                'assets/images/refreshsvg.svg',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // _showToast("assets/images/crossanimate.png");
                                //cardController.triggerLeft();
                                swipeLeft();
                                cross = true;
                              },
                              child: SvgPicture.asset(
                                'assets/images/crosssvg.svg',
                                width: 50,
                                height: 50,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/images/giftboxsvg.svg',
                                width: 70,
                                height: 70,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                swipeRight();
                                // cardController.triggerRight();
                                //
                                // _showToast("assets/images/heartanimate.png");
                              },
                              child: SvgPicture.asset(
                                'assets/images/heartsvg.svg',
                                color: Colors.white,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // cardController.triggerRight();
                                // _showToast("assets/images/staranimate.png");
                              },
                              child: SvgPicture.asset(
                                'assets/images/starsvg.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   bottom: 90,
                      //   left: 10,
                      //   right: 0.0,
                      //   child: SizedBox(
                      //     child: Container(height: 20, child: buildPettiesList()),
                      //   ),
                      // ),
                      Positioned(
                        bottom: 120,
                        left: MediaQuery.of(context).size.width / 3.3,
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
                              borderRadius: BorderRadius.circular(7.0)),
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
                      Positioned(
                        right: MediaQuery.of(context).size.width / 3,
                        // bottom: 100,
                        //left: MediaQuery.of(context).size.width / 2.3,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.white12,
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color:
                                          0 == 0 ? Colors.white : Colors.grey,
                                      borderRadius: BorderRadius.circular(5))),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color:
                                          1 == 1 ? Colors.white : Colors.grey,
                                      borderRadius: BorderRadius.circular(5))),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color:
                                          1 == 1 ? Colors.white : Colors.grey,
                                      borderRadius: BorderRadius.circular(5))),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 4),
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                      color:
                                          1 == 1 ? Colors.white : Colors.grey,
                                      borderRadius: BorderRadius.circular(5)))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    ),
  );
}
