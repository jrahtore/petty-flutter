import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import '../widgets/circular_image.dart';
import '../widgets/gradient_button.dart';
import 'bottom_navigation/chat_detail.dart';

class ItsAMatchScreen extends StatelessWidget {
  final String name, image, user_liked_image, userId, friendUserId;
  const ItsAMatchScreen(
      {Key key,
      @required this.name,
      @required this.image,
      @required this.user_liked_image,
      @required this.userId,
      @required this.friendUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff21242a),
            Color(0x962c2c2e),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/match.svg'),
                )),
                Container(
                  height: 60,
                  child: FittedBox(
                    child: Text(
                      'You and $name have liked\neach other.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularImage(
                      image: image,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircularImage(
                      image: user_liked_image,
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  width: double.infinity,
                  child: GradientButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Get.to(ChatDetail(
                        friendsImage: user_liked_image,
                        friendsName: name,
                        userId: userId,
                        friendsUserId: friendUserId,
                      ));
                    },
                    child: Text(
                      'SEND MESSAGE',
                      style: TextStyle(fontSize: 18),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: OutlineGradientButton(
                    child: Center(
                      child: Text(
                        'KEEP SWIPING',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    gradient: const LinearGradient(
                        colors: [Color(0xfffc267c), Color(0xffff7555)]),
                    strokeWidth: 2,
                    radius: Radius.circular(30),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
