import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/component/payment_controller.dart';
import 'package:petty_app/screens/packeges.dart';
import 'package:petty_app/screens/superpetty_screen.dart';

class PackageExpiryController {
  void gotoPackage(PaymentTypes paymentTypes, BuildContext context) {
    if (paymentTypes == PaymentTypes.superpetty1month ||
        paymentTypes == PaymentTypes.superpetty3month ||
        paymentTypes == PaymentTypes.superpetty6month) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SuperPettyScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Packages()));
    }
  }
}
