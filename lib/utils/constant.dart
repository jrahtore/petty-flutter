import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const greyColor = 0xffD6D8DD;
const borderColor = 0xff015272;

const lableColor = 0xff565656;

const textColor = 0xff1E2661;
const pinkColor = 0xffFF1C7E;

Widget buildProgressBar() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color(0xff015272),
        ),
      ),
    ),
  );
}
