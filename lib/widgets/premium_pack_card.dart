import 'package:flutter/material.dart';
import 'package:petty_app/utils/universal_mixins.dart';

import '../component/payment_controller.dart';

class PremiumPackCard extends StatelessWidget with UniversalMixins {
  final PaymentTypes paymentType;
  final PaymentTypes requiredPaymentType;
  final Color color;
  final String amount;
  final int month;
  PremiumPackCard(
      {@required this.month,
      @required this.paymentType,
      @required this.requiredPaymentType,
      @required this.color,
      @required this.amount,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.fromLTRB(w * 0.03, h * 0.026, w * 0.03, h * 0.02),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              month.toString(),
              style: TextStyle(
                  color:
                      paymentType == requiredPaymentType ? color : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: h * 0.005,
            ),
            Text(
              month > 1 ? "Months" : "Month",
              style: TextStyle(
                  color: paymentType == requiredPaymentType
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: h * 0.005,
            ),
            Text(
              '\$${amount.substring(0, amount.indexOf('.') + 3)}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: paymentType == requiredPaymentType
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: h * 0.005,
            ),
            Text(
              () {
                String s = '\$${getAmount(amount, month)}/mo';
                return s.length == 8 ? ' $s ' : s;
              }(),
              style: TextStyle(
                  color: paymentType == requiredPaymentType
                      ? Colors.black
                      : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
