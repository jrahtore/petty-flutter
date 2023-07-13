import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty_app/component/pack_details.dart';

import '../component/payment_controller.dart';

class PaymentCardInPackages extends StatefulWidget {
  PaymentTypes requiredPaymentTypes;
  PaymentTypes actualPaymentTypes;
  String text;
  String packDurationText;
  double duration;
  String packMonthOrTime;
  PaymentCardInPackages(
      {Key key,
      this.requiredPaymentTypes = PaymentTypes.pettypass1pack,
      this.actualPaymentTypes = PaymentTypes.pettypass1pack,
      this.duration = 1.0,
      this.packDurationText = '1',
      this.packMonthOrTime = 'Pack',
      this.text = 'Petty Pass'})
      : super(key: key);

  @override
  State<PaymentCardInPackages> createState() => _PaymentCardInPackagesState();
}

class _PaymentCardInPackagesState extends State<PaymentCardInPackages> {
  final _packList = PackList();

  String getAmount() {
    NumberFormat formatter = new NumberFormat("0.00");
    double d = _packList.getPaymentAmount(widget.requiredPaymentTypes) /
        widget.duration;
    return '\$' + formatter.format(d) + '/each';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.actualPaymentTypes == widget.requiredPaymentTypes
                  ? Colors.white
                  : Colors.transparent,
              border: widget.actualPaymentTypes == widget.requiredPaymentTypes
                  ? Border.all(color: Color(0xffEC4615), width: 3)
                  : Border.all(color: Colors.transparent)),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(widget.text,
                      style: TextStyle(
                          color: widget.actualPaymentTypes ==
                                  widget.requiredPaymentTypes
                              ? Color(0xffEC4615)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.packDurationText,
                    style: TextStyle(
                        fontSize: 18,
                        color: widget.actualPaymentTypes ==
                                widget.requiredPaymentTypes
                            ? Colors.black
                            : Colors.white),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.packMonthOrTime,
                    style: TextStyle(
                        fontSize: 18,
                        color: widget.actualPaymentTypes ==
                                widget.requiredPaymentTypes
                            ? Colors.black
                            : Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    () {
                      String amount = getAmount();
                      return amount.length == 11 ? amount : ' $amount ';
                    }(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.actualPaymentTypes ==
                                widget.requiredPaymentTypes
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: widget.actualPaymentTypes == widget.requiredPaymentTypes &&
                  widget.duration > 1
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Color(0xffEC4615),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                  height: 30.0,
                  padding: EdgeInsets.all(3),
                  child: Center(
                    child: Text(
                      "${'Save ' + (_packList.getPaymentAmount(widget.requiredPaymentTypes) * 100 / (widget.duration * 19.99)).round().toString()}%",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
