import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/api/terms_of_use.dart';
import 'package:petty_app/utils/constant.dart';

import 'setting/setting_page.dart';

class BeSeenMorePage extends StatefulWidget {
  @override
  _BeSeenMorePageState createState() => _BeSeenMorePageState();
}

class _BeSeenMorePageState extends State<BeSeenMorePage> {
  int selectPremium = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/beeseenmorebackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              //margin: EdgeInsets.only(left: 15,right: 15),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Image.asset(
                        "assets/images/backarrow.png",
                        scale: 2.3,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(400),
                          color: Colors.white),
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/crossback.png",
                      scale: 2,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: Colors.white),
                    padding: EdgeInsets.all(6),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/attachheart.svg',
                      height: 80,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/beseentext.svg',
                          width: 150,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Every month we will\ngive you a free\nPetty Pass",
                          style: TextStyle(
                              color: Color(0xffBFBFBF),
                              fontFamily: "SFUIDisplay",
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectPremium = 0;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectPremium == 0
                      ?
                      //Colors.black
                      Color(0xffBFE3F2)
                      : Colors.white,
                ),
                child: Row(
                  children: [
                    selectPremium == 0
                        ? SvgPicture.asset(
                            'assets/images/cirkle.svg',
                            width: 35,
                          )
                        : SvgPicture.asset(
                            'assets/images/unselectcirkle.svg',
                            width: 35,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "1 Month",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "\$10.99",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "\$8.99 ",
                                style: TextStyle(
                                    color: Color(0xffE04055),
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Limited Time!",
                            style: TextStyle(
                                color: Color(0xffE04055),
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text(
                            "This deal may be here today... and gone tomorrow stop being cheap!",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFUIDisplay",
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectPremium = 1;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectPremium == 1 ? Color(0xffBFE3F2) : Colors.white,
                ),
                child: Row(
                  children: [
                    selectPremium == 1
                        ? SvgPicture.asset(
                            'assets/images/cirkle.svg',
                            width: 35,
                          )
                        : SvgPicture.asset(
                            'assets/images/unselectcirkle.svg',
                            width: 35,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "3 Months",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "\$18.49",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Recommended!",
                            style: TextStyle(
                                color: Color(0xffE04055),
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            "We suggest you try this but if you don't have the money... we understand lol!",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFUIDisplay",
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectPremium = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectPremium == 2 ? Color(0xffBFE3F2) : Colors.white,
                ),
                child: Row(
                  children: [
                    selectPremium == 2
                        ? SvgPicture.asset(
                            'assets/images/cirkle.svg',
                            width: 35,
                          )
                        : SvgPicture.asset(
                            'assets/images/unselectcirkle.svg',
                            width: 35,
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "6 Month",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "\$22.99 ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Best Deal!",
                            style: TextStyle(
                                color: Color(0xffE04055),
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text(
                            "Show your face more and see the people you like!",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "SFUIDisplay",
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ));
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
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                  child: Text(
                    "Continue",
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
            // Container(
            //   height: 35.0,
            //   child: RaisedButton(
            //     onPressed: ()
            //     {
            //
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(builder: (_) =>MatchedPage()),
            //       // );
            //     },
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //     padding: EdgeInsets.all(0.0),
            //     child:
            //   ),
            // ),
            // Container(
            //   height: 50.0,
            //
            //   child: RaisedButton(
            //     color: Colors.black38,
            //     onPressed: () {
            //       Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => SettingPage(),
            //           ));
            //     },
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50.0)),
            //     padding: EdgeInsets.all(0.0),
            //     child: Ink(
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             colors: [
            //               Color(pinkColor),
            //               Color(0xffFF5F5D),
            //             ],
            //
            //             begin: Alignment.topRight,
            //             end: Alignment.bottomLeft,
            //             //transform: GradientRotation(0.7853982),
            //           ),
            //           borderRadius: BorderRadius.circular(15.0)),
            //       child: Container(
            //         constraints: BoxConstraints(
            //             maxWidth: MediaQuery.of(context).size.width / 2,
            //             minHeight: 30.0),
            //         alignment: Alignment.center,
            //         child: Text(
            //           "Continue",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: "SFUIDisplay",
            //               fontSize: 20),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text.rich(
                TextSpan(
                  text:
                      "  By tapping Continue, your payment will be charged to your Google"
                      " Play Account and your subscription will automatically renew "
                      "for the same package length at the same price"
                      " until you cancle in setting in the Google Play Store"
                      " and you agree to our ",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SFUIDisplay",
                      fontSize: 13),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => TermsOfUseApiCall().apiCall(context),
                    ),
                    // can add more TextSpans here...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
