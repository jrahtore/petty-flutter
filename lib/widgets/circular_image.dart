import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  String image;
  CircularImage({this.image, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 72,
        backgroundImage: image != null
            ? NetworkImage(image)
            : AssetImage('assets/images/pettyone.png'),
      ),
    );
  }
}
