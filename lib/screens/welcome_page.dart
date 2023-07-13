import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/screens/initial_photo_add_page.dart';
import 'package:petty_app/utils/constant.dart';

import '../api/terms_of_use.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: SvgPicture.asset(
                'assets/images/welcomeimage.svg',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SvgPicture.asset(
              'assets/images/pettysvg.svg',
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome to Petty",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "SFUIDisplay",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "You must read and agree to following rules "
                "to be part of our Petty System.",
                style: TextStyle(
                  color: Color(0xff7B7B7C),
                  fontFamily: "SFUIDisplay",
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Be Real.",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SFUIDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Color(0xff7B7B7C),
                            ),
                          ),
                          child: Text(
                            "Only upload your own\nphotos and show your\n real biodata.",
                            style: TextStyle(
                              color: Color(0xff7B7B7C),
                              fontFamily: "SFUIDisplay",
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Be Nice.",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SFUIDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Color(0xff7B7B7C),
                            ),
                          ),
                          child: Text(
                            "Be nice to all the users\nand treat them with\nrespect and dignity.",
                            style: TextStyle(
                              color: Color(0xff7B7B7C),
                              fontFamily: "SFUIDisplay",
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Be Cautious.",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SFUIDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Color(0xff7B7B7C),
                            ),
                          ),
                          child: Text(
                            "Avoid catfishes and\nnever give out your\npersonal information. ",
                            style: TextStyle(
                              color: Color(0xff7B7B7C),
                              fontFamily: "SFUIDisplay",
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Be Petty.",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "SFUIDisplay",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: Color(0xff7B7B7C),
                            ),
                          ),
                          child: Text(
                            "Be Social and help us\nmake Petty a better\nplace to date online.",
                            style: TextStyle(
                              color: Color(0xff7B7B7C),
                              fontFamily: "SFUIDisplay",
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return InitialPhotoPage();
                  }, //Category(),
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
                    borderRadius: BorderRadius.circular(20.0)),
                child: Center(
                  child: Text(
                    "I agree",
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
            Flexible(
              child: Text.rich(
                TextSpan(
                  text: "View ",
                  style: TextStyle(
                      color: Colors.black,
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
                    TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy.',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            TermsOfUseApiCall().apiCall(context, type: '3'),
                    ),
                    // can add more TextSpans here...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
