import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/api/otp_generation.dart';
import 'package:petty_app/api/otp_verification.dart';
import 'package:petty_app/models/otp_gen_model.dart';
import 'package:petty_app/models/otp_verify_model.dart';
import 'package:petty_app/screens/welcome_page.dart';
import 'package:petty_app/services/firebase_auth.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/utils/petty_shared_pref.dart';
import 'package:petty_app/widgets/loading_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phone;
  final String countryCode;
  const OtpVerificationPage({Key key, this.phone, this.countryCode})
      : super(key: key);
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  bool isOTP = false;

  VerifyRequestModel verifyRequestModel;
  String userId = "-1";
  String token = "";
  String otpinput = "-0000";
  bool isButtonClickable = false;
  bool isContinue = false;
  bool verify = false;
  bool isLoading = false;
  OtpRequestModel otpRequestModel;

  @override
  void initState() {
    otpRequestModel = new OtpRequestModel(
      phone: "",
      countrycode: "+93",
    );
    verifyRequestModel = new VerifyRequestModel(
      phone: "null",
      userId: "null",
      countrycode: "+93",
      otp: "null",
    );
    verify = false;
    isContinue = false;
    isButtonClickable = false;
    loadDetails();
    otpGenerationApi();

    super.initState();
  }

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode, String dialCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = prefs.getString("userId");
    print("Getter userID " + _userId);
    userId = _userId;
    bool _verify = prefs.getBool("verify");
    verify = _verify;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   gradient: RadialGradient(
        //     colors: [
        //       Color(0xffee1d7f3),
        //       Color(0xfffaf0f3),],
        //     center: Alignment(0, -1),
        //
        //   ),
        // ),
        child: Container(
          margin: EdgeInsets.all(15),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SvgPicture.asset(
                          'assets/images/pettysvg.svg',
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/phoneverification.svg',
                              height: 90,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Expanded(child: SizedBox()),
                        //Text("\"Don't Date Who You Don't like\"",style: TextStyle(color: Color(textColor),fontSize: 10),),

                        // SizedBox(height: 40,),
                        //
                        // Text("What's your phone number?",style: TextStyle(
                        //   color: Color(textColor),
                        //   fontFamily: "SFUIDisplay",
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 18,
                        //
                        // ),),
                        // SizedBox(height: 6,),
                        // Text("Please enter your phone number to verify your \naccount         ",
                        //   style: TextStyle(
                        //       color: Color(textColor),
                        //   fontFamily: "myfonts",
                        //     fontSize: 15
                        // ),),
                        // SizedBox(height: 20,),

                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 20, right: 20),
                        //   height: 70,
                        //   child: TextFormField(
                        //     keyboardType: TextInputType.text,
                        //
                        //     decoration: InputDecoration(
                        //
                        //       // suffixIcon: Container(
                        //       //
                        //       //   height: 10,
                        //       //   width: 60,
                        //       //   decoration: BoxDecoration(
                        //       //       color: Color(0xff015272),
                        //       //     borderRadius: BorderRadius.circular(15)
                        //       //   ),
                        //       //   child: IconButton(
                        //       //     padding: EdgeInsets.all(0),
                        //       //     color: Color(0xff015272),
                        //       //     iconSize: 30,
                        //       //
                        //       //
                        //       //     icon: Text("Verify",style: TextStyle(color: Colors.white),),
                        //       //     onPressed: () {
                        //       //
                        //       //     },
                        //       //   ),
                        //       // ),
                        //       fillColor: Colors.white,
                        //       hintText: "Password",
                        //       labelText: "Password",
                        //       labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        //       hintStyle: TextStyle(
                        //           fontFamily: 'myfonts', color: Colors.grey, fontSize: 15),
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey),
                        //       ),
                        //       focusedBorder: UnderlineInputBorder(
                        //         borderSide: BorderSide(color: Colors.grey),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(greyColor),
                              ),
                            ),

                            // borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    //color: Color(0xFFE0E0E0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {
                                      otpinput = value,
                                      setState(() {
                                        loadDetails();
                                        isButtonClickable = verify;
                                      }),
                                      isContinue = false,
                                    },
                                    cursorColor: Colors.grey,
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        // border: OutlineInputBorder(
                                        //   borderSide: const BorderSide(
                                        //       color: Color(greyColor), width: 1.0),
                                        //   borderRadius: BorderRadius.circular(16.0),
                                        // ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        hintText: "Enter Verification Code"),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // ElevatedButton(
                              //   child: Text(
                              //     "Verify",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   style: ElevatedButton.styleFrom(
                              //     onPrimary: Color(0xff015272),
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.all(
                              //             Radius.circular(16))),
                              //     onSurface: Color(0xff015272),
                              //     padding: EdgeInsets.only(
                              //         top: 0.5,
                              //         bottom: 0.5,
                              //         left: 0.5,
                              //         right: 0.5),
                              //     side: BorderSide(
                              //       color: Color(greyColor),
                              //     ),
                              //   ),
                              // onPressed: isButtonClickable
                              //     ? () {
                              //         setState(() {
                              //           isLoading = true;
                              //         });
                              //         if (isButtonClickable) {
                              //           buttonClicked();
                              //         }
                              //         setState(() {
                              //           isButtonClickable = false;
                              //         });
                              //         if (isLoading) {
                              //           showLoadingIndicator("Verifying..");
                              //           apiCall();
                              //         } else {
                              //           hideOpenDialog();
                              //         }
                              //       }
                              //     : null,
                              //   ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          child: Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            onPrimary: Color(0xff015272),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            onSurface: Color(0xff015272),
                            padding: EdgeInsets.only(
                                top: 0.5, bottom: 0.5, left: 50, right: 50),
                            side: BorderSide(
                              color: Color(greyColor),
                            ),
                          ),
                          onPressed: isButtonClickable
                              ? () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (isButtonClickable) {
                                    buttonClicked();
                                  }
                                  setState(() {
                                    isButtonClickable = false;
                                  });
                                  if (isLoading) {
                                    showLoadingIndicator("Verifying..");

                                    apiCall();
                                  }
                                }
                              : null,
                        ),

                        Text(
                          'Disclaimer: Message and data rates may apply.',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),

                        SizedBox(
                          height: 25,
                        ),

                        // Container(
                        //   height: 50.0,
                        //   child: RaisedButton(
                        //     onPressed: () {
                        //       Navigator.of(context).push(
                        //         MaterialPageRoute(builder: (_) => Category()),
                        //       );
                        //     },
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10.0)),
                        //     padding: EdgeInsets.all(0.0),
                        //     child: Ink(
                        //       decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //               colors: [
                        //                 Color(0xffFF5F5D),
                        //                 Color(pinkColor),
                        //               ],
                        //               begin: Alignment.bottomLeft,
                        //               end: Alignment.topRight
                        //           ),
                        //           borderRadius: BorderRadius.circular(10.0)
                        //       ),
                        //       child: Container(
                        //         constraints: BoxConstraints(
                        //             maxWidth: double.infinity,
                        //             minHeight: 50.0),
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           "Continue",
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //               color: Colors.black
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),

                        //goToSignUp(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void setDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PettySharedPref.setAccessToken(prefs, token);
    PettySharedPref.setUserId(prefs, userId);
    await FirebaseAuthService()
        .FirebaseSignUp(userId + '@gmail.com', userId + 'akhil@');
  }

  Future<void> apiCall() async {
    verifyRequestModel.phone = widget.phone;
    verifyRequestModel.countrycode = widget.countryCode;
    verifyRequestModel.userId = userId;
    verifyRequestModel.otp = otpinput;
    if (otpinput.length == 4) {
      OtpVerification otpVerification = new OtpVerification();
      otpVerification.otpver(verifyRequestModel).then((value) async {
        Navigator.pop(context);

        if (value != null) {
          setState(() {
            isOTP = false;
            isLoading = false;
          });
          if (value.status == "success") {
            print(value.message);
            userId = value.data.userId;
            token = value.data.token;

            print(value.data.userId);
            isOTP = true;
            isContinue = true;

            if (isOTP) {
              await setDetails();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => WelcomePage(),),
                  (route) => false);
            }
          } else {
            isButtonClickable = true;
            isContinue = false;
            final snackBar = SnackBar(
                content: Text(value.message),
                duration: const Duration(seconds: 1),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print(value.message);
          }
        }
      });
    } else {
      Navigator.pop(context);
    }
  }

  void buttonClicked() async {
    Duration time = Duration(seconds: 10);
    setState(() {
      isButtonClickable = false;
      print("Clicked once");
      Future.delayed(time, () {
        setState(() {
          isButtonClickable = true;
        });
      });
    });
  }

  void showLoadingIndicator([String text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.black87,
          content: LoadingIndicator(text: text),
        );
      },
    );
  }

  void otpGenerationApi() {
    otpRequestModel.phone = widget.phone;
    otpRequestModel.countrycode = widget.countryCode;
    OtpGeneration otpGeneration = new OtpGeneration();
    otpGeneration.otpgen(otpRequestModel).then((value) {
      if (value != null) {
        setState(() {
          isOTP = false;
          verify = true;
          isLoading = false;
        });

        if (value.status == "success") {
          print(value.message);
        } else {
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
