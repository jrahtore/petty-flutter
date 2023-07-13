import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PhotoIconStack extends StatelessWidget {
  final Color largeCircleColor;
  final Color smallCircleColor;
  final String largeImage;
  final String smallImage;

  PhotoIconStack(
      {Key key,
      this.largeCircleColor,
      this.largeImage,
      this.smallCircleColor,
      this.smallImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30.0, right: 10),
            child: CircleAvatar(
              radius: height * 0.080,
              backgroundColor: largeCircleColor ?? Color(0xffEC4615),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: height * 0.075,
                backgroundImage:
                    AssetImage(largeImage ?? "assets/pkgsprofile.png"),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 0.0,
            child: CircleAvatar(
              radius: height * 0.040,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: smallCircleColor ?? Color(0xffEC4615),
                radius: height * 0.037,
                child: SvgPicture.asset(
                  smallImage ?? 'assets/images/refpkg.svg',
                  // "assets/images/refpkg.svg",
                  width: height * 0.032,
                  height: height * 0.032,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
