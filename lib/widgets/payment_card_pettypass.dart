import 'package:flutter/material.dart';

import '../component/pack_details.dart';
import '../component/payment_controller.dart';

class PaymentCardPettyPass extends StatelessWidget {
  final PaymentTypes requiredPaymentTypes;
  final PaymentTypes actualPaymentTypes;
  final String packDurationText;
  final double duration;
  final String packMonthOrTime;
  PaymentCardPettyPass({
    Key key,
    this.requiredPaymentTypes = PaymentTypes.pettypass1pack,
    this.actualPaymentTypes = PaymentTypes.pettypass1pack,
    this.duration = 1.0,
    this.packDurationText = '1',
    this.packMonthOrTime = 'Pack',
  }) : super(key: key);

  final _packList = PackList();

  getColor() {
    if (requiredPaymentTypes == PaymentTypes.pettypass1pack ||
        requiredPaymentTypes == PaymentTypes.pettypass5pack ||
        requiredPaymentTypes == PaymentTypes.pettypass10pack) {
      return Colors.yellow;
    } else if (requiredPaymentTypes == PaymentTypes.superpetty1month ||
        requiredPaymentTypes == PaymentTypes.superpetty3month ||
        requiredPaymentTypes == PaymentTypes.superpetty6month) {
      return Colors.red;
    }
  }

  getOneMonthPaymentType() {
    if (requiredPaymentTypes == PaymentTypes.pettypass1pack ||
        requiredPaymentTypes == PaymentTypes.pettypass5pack ||
        requiredPaymentTypes == PaymentTypes.pettypass10pack) {
      return PaymentTypes.pettypass1pack;
    } else if (requiredPaymentTypes == PaymentTypes.superpetty1month ||
        requiredPaymentTypes == PaymentTypes.superpetty3month ||
        requiredPaymentTypes == PaymentTypes.superpetty6month) {
      return PaymentTypes.superpetty1month;
    }
  }

  getAmountEach() {
    String x =
        "\$${(_packList.getPaymentAmount(requiredPaymentTypes) / duration).toStringAsFixed(2)}/${packMonthOrTime == 'Pack' ? 'each' : 'mo'}";
    if (x.length == 11 || x.length == 9) {
      return x;
    }
    return " $x ";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: actualPaymentTypes == requiredPaymentTypes
              ? Colors.white
              : Colors.transparent,
          border: actualPaymentTypes == requiredPaymentTypes
              ? Border.all(color: getColor(), width: 3)
              : Border.all(color: Colors.transparent)),
      child: Stack(
        children: [
          Container(
            height: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: FittedBox(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    packDurationText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: actualPaymentTypes == requiredPaymentTypes
                            ? getColor()
                            : Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    packMonthOrTime,
                    style: TextStyle(
                        fontSize: 18,
                        color: actualPaymentTypes == requiredPaymentTypes
                            ? Colors.black
                            : Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    getAmountEach(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: actualPaymentTypes == requiredPaymentTypes
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
            ),
          ),
          actualPaymentTypes == requiredPaymentTypes && duration > 1
              ? Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                          color: getColor(),
                          width: double.infinity,
                          padding: EdgeInsets.all(3),
                          child: Center(
                              child: FittedBox(
                            child: Text(
                              () {
                                double amount1month =
                                    _packList.getPaymentAmount(
                                          getOneMonthPaymentType(),
                                        ) *
                                        100 *
                                        duration;
                                amount1month = amount1month.truncate() / 100.0;
                                double amountNmonth =
                                    _packList.getPaymentAmount(
                                            requiredPaymentTypes) *
                                        100;
                                amountNmonth = amountNmonth.truncate() / 100.0;
                                return 'Save ${((1 - (amountNmonth / amount1month)) * 100).round()}%';
                              }(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))),
                    ),
                    Flexible(
                      flex: 6,
                      child: SizedBox(),
                    )
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
