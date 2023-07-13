import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petty_app/screens/authentication/sign_up_page.dart';
import 'package:petty_app/services/auth.dart';

import '../../api/terms_of_use.dart';
import '../../services/location_service.dart';
import '../../utils/constant.dart';
import '../phone_number/phone_number.dart';

class Authenticate extends StatefulWidget {
  final Function toggleView;
  const Authenticate({Key key, this.toggleView}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int currentImagePosition;
  bool check = true;

  @override
  void initState() {
    super.initState();
    LocationService().storeCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0.1,
            child: Container(
              height: h / 2,
              // width: MediaQuery.of(context).size.width,
              child: buildSlider(),
            ),
          ),
          Positioned(
            top: h / 2.35,
            bottom: 0,
            child: Container(
              width: w,
              //margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(h * 0.054),
                    topLeft: Radius.circular(h * 0.054)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      "assets/images/welcometo.svg",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/images/pettyfirsticon.svg',
                    ),
                  ),
              
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Expanded(
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/dontdatewelcome.svg",
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          print('authenticate/phonenumberpage');
                          return PhoneNumberPage();
                        },
                        //AuthenticateScreenWrapper(true),
                      ));
                    },
                    child: Center(
                      child: Container(
                        height: h * 0.06,
                        margin: EdgeInsets.only(
                          left: w / 6,
                          right: w / 6,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff015272),
                            borderRadius: BorderRadius.circular(h * 0.022)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: SvgPicture.asset(
                                  "assets/images/phone.svg",
                                  height: h * 0.019,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign in With Mobile Number",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "SFUIDisplay",
                                    fontSize: h * 0.019,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.017,
                  ),
                  InkWell(
                    onTap: () async {
                      showToast('Feature not available yet', true);
                      // SignInWithFacebook signInFB = SignInWithFacebook();
                      // FacebookModel facebookModel = await signInFB.signIn();
                      // bool isSuccess =
                      //     await FacebookAdd().facebookAdd(facebookModel);
                      // isSuccess
                      //     ? Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => PhoneNumberPage()))
                      //     : () {};
                    },
                    child: Center(
                      child: Container(
                        height: h * 0.06,
                        margin: EdgeInsets.only(
                          left: w / 6,
                          right: w / 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff015272),
                          ),
                          borderRadius: BorderRadius.circular(h * 0.022),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/images/fb.svg",
                                height: h * 0.02,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Sign in With Facebook",
                              style: TextStyle(
                                color: Color(0xff015272),
                                fontFamily: "SFUIDisplay",
                                fontSize: h * 0.019,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.017,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xff999898),
                            fontFamily: "SFUIDisplay",
                          ),
                          textScaleFactor: h * 0.0012,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              print('authenticate/signup');
                              return SignUp(widget.toggleView);
                            }));
                            //widget.toggleView();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Color(textColor),
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold),
                            textScaleFactor: h * 0.0013,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
              
                  Container(
                    margin: EdgeInsets.only(
                      left: w / 6,
                      right: w / 6,
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "By ",
                        style: TextStyle(
                          color: Color(0xff545454),
                          fontFamily: "SFUIDisplay",
                          fontSize: h * 0.015,
                          letterSpacing: 0.5,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Continuing, You agree to our ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => TermsOfUseApiCall()
                                  .apiCall(context, type: '3'),
                          ),
                          TextSpan(
                            text: ', ',
                          ),
                          TextSpan(
                            text: 'Cookie Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => TermsOfUseApiCall()
                                  .apiCall(context, type: '6'),
                          ),
                          TextSpan(
                            text: ' & ',
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => TermsOfUseApiCall().apiCall(context),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
              
                  // Text("By Continuing you agree to our policy policy")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // build image slider
  Widget buildSlider() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        images: [
          FittedBox(
            child: Image.asset(
              "assets/images/welcomebg.png",
            ),
            fit: BoxFit.fitWidth,
          ),
          FittedBox(
            child: Image.asset(
              "assets/images/image4.png",
            ),
            fit: BoxFit.cover,
          ),
          FittedBox(
            child: Image.asset(
              "assets/images/image5.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ],
        dotBgColor: Colors.transparent,
        dotColor: Colors.transparent,
        dotIncreasedColor: Colors.transparent,
        dotVerticalPadding: 180,
        autoplayDuration: Duration(seconds: 3),
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
}
