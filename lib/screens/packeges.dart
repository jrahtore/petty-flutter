import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/screens/go_premium_pkgs.dart';
import 'package:petty_app/widgets/payment_card_packages.dart';

import '../component/payment_controller.dart';
import '../widgets/photo_icon_stack.dart';

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  int currentImagePosition = 0;
  bool check = true;
  bool isContinuePressed = false;
  ScrollController _scrollController;
  bool isScrollAtStart = true;

  PaymentTypes paymentTypes = PaymentTypes.rewind1month;
  PaymentBrain _paymentBrain = PaymentBrain();

  // getCurrentImage() {
  //   if (currentImagePosition == 0) {
  //     //rewind
  //     // return 'assets/images/giftbox.svg';
  //     return "assets/images/refpkg.svg";
  //   } else if (currentImagePosition == 2) {
  //     //super petty
  //     return 'assets/images/superpetty.svg';
  //   }
  //   return 'assets/images/extrapetty.svg';
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isLeft = _scrollController.position.pixels == 0;
        if (isLeft) {
          setState(() {
            isScrollAtStart = true;
          });
        } else {
          setState(() {
            isScrollAtStart = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            color: Colors.black87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset("assets/packagesbg.png"),

                SizedBox(
                  height: height * 0.025,
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
                            color: Colors.black54),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                PhotoIconStack(),
                SizedBox(
                  child: buildSlider(),
                  height: height * 0.13,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Icon(
                //         Icons.keyboard_arrow_left,
                //         color: isScrollAtStart ? Colors.grey : Colors.white,
                //       ),
                //       Icon(
                //         Icons.keyboard_arrow_right,
                //         color: !isScrollAtStart ? Colors.grey : Colors.white,
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: height * 0.22,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       paymentTypes = PaymentTypes.unlock1time;
                        //     });
                        //   },
                        //   child: PaymentCardInPackages(
                        //     requiredPaymentTypes: PaymentTypes.unlock1time,
                        //     actualPaymentTypes: paymentTypes,
                        //     packDurationText: '1',
                        //     duration: 1.0,
                        //     text: 'Unlock',
                        //     packMonthOrTime: 'Time',
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              paymentTypes = PaymentTypes.rewind1month;
                            });
                          },
                          child: PaymentCardInPackages(
                            requiredPaymentTypes: PaymentTypes.rewind1month,
                            actualPaymentTypes: paymentTypes,
                            packDurationText: '1',
                            duration: 1.0,
                            text: 'Rewind',
                            packMonthOrTime: 'Month',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              paymentTypes = PaymentTypes.rewind3month;
                            });
                          },
                          child: PaymentCardInPackages(
                            requiredPaymentTypes: PaymentTypes.rewind3month,
                            actualPaymentTypes: paymentTypes,
                            packDurationText: '3',
                            duration: 3.0,
                            text: 'Rewind',
                            packMonthOrTime: 'Month',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              paymentTypes = PaymentTypes.rewind6month;
                            });
                          },
                          child: PaymentCardInPackages(
                            requiredPaymentTypes: PaymentTypes.rewind6month,
                            actualPaymentTypes: paymentTypes,
                            packDurationText: '6',
                            duration: 6.0,
                            text: 'Rewind',
                            packMonthOrTime: 'Month',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: height * 0.07,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffC92986)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(height * 0.035))),
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
                  height: height * 0.021,
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
                  height: height * 0.024,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: height * 0.085,
                  child: ElevatedButton(
                    // color: Color(0xffE92917),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Over 100 Super Likes/Month')
                      ],
                    )),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //         BorderRadius.circular(height * 0.085 / 2)),
                  ),
                ),

                SizedBox(
                  height: height * 0.01,
                ),
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
                  height: height * 0.02,
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
    return Carousel(
      images: [
        getPremiumDetail(
            // assets/images/giftbox.svg",
            "Rewind",
            "Retrieve disliked or accidental",
            "disliked users"),

        getPremiumDetail(
            // "assets/images/superpetty.svg",
            // "Wanna Go Backwards",
            // "Go back unlimited if you",
            // "passed by premium"),
            "Rewind",
            "Retrieve disliked or accidental",
            "disliked users"),
        getPremiumDetail(
            // "assets/images/extrapetty.svg",
            // "Rewind",
            // "Retrieve back disliked users",
            // "No more accidental dislike"),
            "Rewind",
            "Retrieve disliked or accidental",
            "disliked users"),
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
      // dotVerticalPadding: MediaQuery.of(context).size.height * 0.001,
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
    );
  }

  Widget getPremiumDetail(String text1, String text2, String text3) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text2,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              text3,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
