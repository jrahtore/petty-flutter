import 'package:flutter/material.dart';

class FullScreenPhotoPage extends StatelessWidget {
  final String image;
  const FullScreenPhotoPage(this.image, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
