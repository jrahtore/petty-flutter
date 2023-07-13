import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/utils/constant.dart';

import '../component/pack_details.dart';
import '../component/payment_controller.dart';

class GetPettyPasses extends StatefulWidget {
  @override
  State<GetPettyPasses> createState() => _GetPettyPassesState();
}

class _GetPettyPassesState extends State<GetPettyPasses> {
  PaymentTypes paymentTypes = PaymentTypes.pettypass1pack;
  bool isButtonClicked = false;

  final _paymentBrain = PaymentBrain();

  final _packList = PackList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xffd1d9dc),
                Color(0xffdf3ef),
                Colors.white30
              ])),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Image.asset(
                      "assets/images/crossback.png",
                      scale: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: Color(0xff1E2661),
                    ),
                    padding: EdgeInsets.all(6),
                  ),
                ),
              ),

              Image.asset(
                "assets/images/getpassestorrance.png",
                scale: 3.0,
              ),
              SizedBox(
                height: 20,
              ),

              SvgPicture.asset(
                'assets/images/pettytime.svg',
                height: 50,
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "It's peak time in your era. So get a\n",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                  /*defining default style is optional */
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Petty Pass ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffED6963),
                            fontSize: 15)),
                    TextSpan(
                        text: 'now for next ',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: '30 Mins\n ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xffED6963))),
                    TextSpan(
                      text: 'and match with more people',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
              // SvgPicture.asset(
              //   'assets/images/itspettytime.svg',
              //
              // ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentTypes = PaymentTypes.pettypass1pack;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: paymentTypes == PaymentTypes.pettypass1pack
                                  ? Colors.black
                                  : Colors.transparent,
                              border:
                                  paymentTypes == PaymentTypes.pettypass1pack
                                      ? Border.all(
                                          color: Color(0xffEC4615), width: 3)
                                      : Border.all(color: Colors.transparent)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("1",
                                  style: TextStyle(
                                      color: paymentTypes ==
                                              PaymentTypes.pettypass1pack
                                          ? Color(0xffEC4615)
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Pack",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass1pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '\$${_packList.getPaymentAmount(PaymentTypes.pettypass1pack).toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass1pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentTypes = PaymentTypes.pettypass5pack;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: paymentTypes == PaymentTypes.pettypass5pack
                                  ? Colors.black
                                  : Colors.transparent,
                              border:
                                  paymentTypes == PaymentTypes.pettypass5pack
                                      ? Border.all(
                                          color: Color(0xffEC4615), width: 3)
                                      : Border.all(color: Colors.transparent)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              Text("5",
                                  style: TextStyle(
                                      color: paymentTypes ==
                                              PaymentTypes.pettypass5pack
                                          ? Color(0xffEC4615)
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Pack",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass5pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '\$${_packList.getPaymentAmount(PaymentTypes.pettypass5pack).toString().replaceFirst('.0', '')}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass5pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                () {
                                  double amount = _packList.getPaymentAmount(
                                          PaymentTypes.pettypass5pack) *
                                      100 /
                                      5;
                                  double num = amount.truncate() / 100.0;

                                  return "\$${num.toStringAsFixed(2)}/each";
                                }(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass5pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Expanded(
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          paymentTypes = PaymentTypes.pettypass10pack;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 15.0),
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  paymentTypes == PaymentTypes.pettypass10pack
                                      ? Colors.black
                                      : Colors.transparent,
                              border:
                                  paymentTypes == PaymentTypes.pettypass10pack
                                      ? Border.all(
                                          color: Color(0xffEC4615), width: 3)
                                      : Border.all(color: Colors.transparent)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              Text("10",
                                  style: TextStyle(
                                      color: paymentTypes ==
                                              PaymentTypes.pettypass10pack
                                          ? Color(0xffEC4615)
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Pack",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass10pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '\$${_packList.getPaymentAmount(PaymentTypes.pettypass10pack).toString().replaceFirst('.0', '')}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass10pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                () {
                                  double amount = _packList.getPaymentAmount(
                                          PaymentTypes.pettypass10pack) *
                                      100 /
                                      10;
                                  double num = amount.truncate() / 100.0;

                                  return "\$${num.toStringAsFixed(2)}/each";
                                }(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: paymentTypes ==
                                            PaymentTypes.pettypass10pack
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Expanded(
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  if (!isButtonClicked) {
                    isButtonClicked = true;
                    isButtonClicked =
                        await _paymentBrain.makePayment(context, paymentTypes);
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(pinkColor),
                          Color(0xffFF5F5D),
                        ],

                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        //transform: GradientRotation(0.7853982),
                      ),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      "Get Petty Pass",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SFUIDisplay",
                          fontSize: 20),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xff7B7B7C)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      "No Thanks",
                      style: TextStyle(
                        color: Color(0xff7B7B7C),
                        fontFamily: "SFUIDisplay",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
