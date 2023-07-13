import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OTPVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_getHeading(context), _getTick(context)]));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          'OTP Veriifed.',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Widget _getTick(context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/otp_verified.svg',
          height: 50,
        ),
      ),
    );
  }
}
