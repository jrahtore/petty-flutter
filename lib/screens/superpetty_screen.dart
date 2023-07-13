import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/screens/go_premium_pkgs.dart';

import '../component/payment_controller.dart';
import '../widgets/payment_card_pettypass.dart';

class SuperPettyScreen extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<SuperPettyScreen> {
  int currentImagePosition = 0;
  bool check = true;
  bool isContinuePressed = false;
  Color _color = Colors.red;

  PaymentTypes paymentTypes = PaymentTypes.superpetty1month;
  PaymentBrain _paymentBrain = PaymentBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/packagesbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset("assets/packagesbg.png"),

                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'BUY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'SFUIDisplay'),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 5.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: _color,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'SUPER PETTY',
                            style: TextStyle(
                              color: _color,
                              fontSize: 30.0,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 5.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: _color,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset(
                    'assets/images/extrapetty.svg',
                    color: _color,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        // color: Color(0xff707070),
                        child: buildSlider())),
                SizedBox(
                  height: 10,
                ),

                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.superpetty1month;
                              });
                            },
                            child: PaymentCardPettyPass(
                              requiredPaymentTypes:
                                  PaymentTypes.superpetty1month,
                              actualPaymentTypes: paymentTypes,
                              packDurationText: '1',
                              duration: 1.0,
                              packMonthOrTime: 'Month',
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.superpetty3month;
                              });
                            },
                            child: PaymentCardPettyPass(
                              requiredPaymentTypes:
                                  PaymentTypes.superpetty3month,
                              actualPaymentTypes: paymentTypes,
                              packDurationText: '3',
                              duration: 3.0,
                              packMonthOrTime: 'Month',
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.superpetty6month;
                              });
                            },
                            child: PaymentCardPettyPass(
                              requiredPaymentTypes:
                                  PaymentTypes.superpetty6month,
                              actualPaymentTypes: paymentTypes,
                              packDurationText: '6',
                              duration: 6.0,
                              packMonthOrTime: 'Month',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffC92986)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                    ),
                    onPressed: () async {
                      if (!isContinuePressed) {
                        isContinuePressed = true;
                        await _paymentBrain.makePayment(context, paymentTypes);
                        isContinuePressed = false;
                      }
                    },
                    child: Center(
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 45,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 3,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "or Upgrade",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 3,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 55,
                  child: ElevatedButton(
                    // color: _color,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoPremiumPkgs(),
                          ));
                    },
                    // textColor: Colors.white,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "GO PREMIUM",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Over 100 Super Likes/Month',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 15, right: 15),
                //   child: Text.rich(
                //     TextSpan(
                //       text:
                //           "By tapping Continue, your payment will be charged to your "
                //           "Google Play Acccount and your subscription will automatically"
                //           " renew for the same package length at the same price until you"
                //           " cancel in setting in the Google Play Store and you agree to our",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontFamily: "SFUIDisplay",
                //           fontSize: 13),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: '',
                //           style: TextStyle(
                //             color: Colors.pink,
                //             decoration: TextDecoration.underline,
                //           ),
                //         ),
                //         // can add more TextSpans here...
                //       ],
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No Thanks",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // build image slider
  Widget buildSlider() {
    return SizedBox(
      //height: MediaQuery.of(context).size.height / 2,
      child: Carousel(
        images: [
          getPremiumDetail(
              // assets/images/giftbox.svg",
              "Super Petty",
              "Highlight your profile to a specific user",
              "Higher chance to get matched"),

          getPremiumDetail(
              // assets/images/giftbox.svg",
              "Be Extra Petty",
              "Better chance at matching giving your pet",
              "peeves to users"),
          getPremiumDetail(
              // assets/images/giftbox.svg",
              "Super Petty",
              "Highlight your profile to a specific user",
              "Higher chance to get matched"),

          // getPremiumDetail(
          //     "assets/images/removedpetty.svg",
          //     " If You Missed Something Go Back",
          //     "Get Unlimited Rewinds and Reverse",
          //     "Mistaken Passes"),
          // getPremiumDetail(
          //     "assets/images/starpetty.svg",
          //     " Let Them Know You Interested",
          //     "5x the chance to be Liked more and",
          //     "matched with Super Likes "),
          // getPremiumDetail(
          //     "assets/images/removepetty.svg",
          //     "Remove Interruptions",
          //     "Ads are turned off so you can experience",
          //     "being Petty more"),
        ],
        dotBgColor: Colors.transparent,
        dotIncreaseSize: 1.1,
        dotColor: Colors.white24,
        dotVerticalPadding: -20,
        autoplayDuration: Duration(seconds: 10),
        onImageChange: (a, b) {
          setState(() {
            currentImagePosition = b;
            if (currentImagePosition == 3) {
              check = false;
            } else {
              check = true;
            }
          });
        },
      ),
    );
  }

  Widget getPremiumDetail(String text1, String text2, String text3) {
    return FittedBox(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            text1,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            text2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            text3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
