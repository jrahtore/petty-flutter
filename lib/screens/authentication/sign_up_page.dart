// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:petty/screens/authentication/sign_in_page.dart';
// import 'package:petty/screens/phone_number/phone_number.dart';
// import 'package:petty/services/database.dart';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
//mport 'package:firebanse_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petty_app/models/register_model.dart';
import 'package:petty_app/screens/authentication/authenticate.dart';
import 'package:petty_app/screens/authentication/phone_country_input.dart';
import 'package:petty_app/screens/phone_number/phone_number.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/registeration.dart';
import '../../services/auth.dart';
import '../../services/location_service.dart';
import '../../utils/loading_overlay.dart';
import '../../utils/petty_shared_pref.dart';
import 'otp_verification.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  StreamSubscription subscription;

  RegisterRequestModel requestModel;
  bool isApiCallService = false;
  String phoneinput;
  String countryinput = '+93';
  //String location = "Select your location";
  final locationController = TextEditingController();

  String user_location = 'location';
  String user_latitude = '3.34';
  String user_longitude = '39.666';

  _getLocationFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _location = PettySharedPref.getLocation(prefs);
    String _lat = PettySharedPref.getLat(prefs).toString();
    String _lon = PettySharedPref.getLon(prefs).toString();
    user_location = _location;
    user_latitude = _lat;
    user_longitude = _lon;
  }

  _getLocationDetails() async {
    try {
      _getLocationFromPrefs();
      await LocationService().storeCurrentLocation();
      _getLocationFromPrefs();
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
  }

  void initState() {
    super.initState();
    //todo remove 22092022
    // _getCurrentLocation();
    _getLocationDetails();
    requestModel = new RegisterRequestModel(
      name: "",
      phone: "",
      latitude: "",
      longitude: "",
      countrycode: "+93",
      location: "",
      age: "",
      gender: "",
    );
    phoneinput = "";
    countryinput = "+93";

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Get.snackbar("ERROR", "No Internet Connection", colorText: Colors.red);
      }
    });
    // var x = Provider.of<Categories>(context, listen: false).fetchCategories();
  }

  updateSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PettySharedPref.setUserCountryCode(
        prefs, '${requestModel.countrycode.trim()}');
    PettySharedPref.setUserMobileNumber(prefs, '${requestModel.phone.trim()}');
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
    String _phoneinput = prefs.getString("phoneinput");
    phoneinput = _phoneinput;
    print("Getter phone input" + _phoneinput);
    String _countryinput = prefs.getString("countryinput");
    print("Getter country code input " + _countryinput);
    countryinput = _countryinput;
  }

  String selectedDate = "DD/MM//YY";
  List gender = ["Male", "Female", "Other"];

  String select;
  bool showPassword = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  String password = '';
  bool isProgressEnabled = false;
  DateTime dateofbirth;

  //final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: isProgressEnabled
          ? buildProgressBar()
          : Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/pettysvg.svg',
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/newhere.svg',
                              height: 90,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Name",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => requestModel.name = input,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Enter your name",
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Color(0xff999898),
                                fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Phone Number",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        PhoneCountryInput(
                          onPhoneNumberChange: onPhoneNumberChange,
                          initialPhoneNumber: phoneNumber,
                          initialSelection: phoneIsoCode,
                          enabledCountries: [
                            '+233',
                            '+1',
                            '+91',
                            '+93',
                            '+55',
                            '+92',
                            '+74',
                            '+888',
                            "+358",
                            "+355",
                            "+213",
                            "+244",
                            "+54",
                            "+672",
                            "+61",
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Age",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          // maxLength: 10,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,

                          onChanged: (value) => {
                            requestModel.age = value,
                          },

                          validator: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                int.parse(value) < 18) {
                              return "Age should be 18 or above";
                            }
                            return null;
                          },
                          // onSubmitted: (value) {
                          //   setState(() {
                          //    dateofbirth = value as DateTime;
                          ///    int age = DateTime.now().year - dateofbirth.year;
                          //   int month1 = DateTime.now().month;
                          //   int month2 = dateofbirth.month;
                          //  if (month2 > month1) {
                          //    age--;
                          //  } else if (month1 == month2) {
                          //    int day1 = DateTime.now().day;
                          //   int day2 = dateofbirth.day;
                          //   if (day2 > day1) {
                          //     age--;
                          ///   }
                          // }
                          // requestModel.age = age as String;
                          //
                          //});
                          //},
                          //controller: _controllerDOB,
                          //focusNode: _focusNodeDOB,
                          decoration: InputDecoration(
                            hintText: 'Enter your age',
                            counterText: '',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Color(0xff999898),
                                fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        //buildSelectDate(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Gender",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 59,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(borderColor)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: <Widget>[
                              addRadioButton(0, 'Male'),
                              addRadioButton(1, 'Female'),
                              addRadioButton(2, 'Others'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Occupation",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          // maxLength: 10,
                          textInputAction: TextInputAction.next,

                          onChanged: (value) => {
                            requestModel.occupation = value,
                          },
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Occupation cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your profession',
                            counterText: '',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Color(0xff999898),
                                fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        //buildSelectDate(),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "About",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          // maxLength: 10,
                          maxLines: 3,
                          textInputAction: TextInputAction.next,

                          onChanged: (value) => {
                            requestModel.about = value,
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "About cannot be empty";
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: 'Write something about yourself',
                            counterText: '',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Color(0xff999898),
                                fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        //buildSelectDate(),
                        SizedBox(
                          height: 20,
                        ),

                        Text(
                          "Hobbies",
                          style: TextStyle(
                            color: Color(lableColor),
                            fontFamily: "SFUIDisplay",
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          // maxLength: 10,
                          textInputAction: TextInputAction.next,

                          onChanged: (value) => {
                            requestModel.hobbies = value,
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Hobbies cannot be empty";
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: 'Enter what interesting things you do',
                            counterText: '',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Color(0xff999898),
                                fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(borderColor), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        //buildSelectDate(),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          onTap: () async {
                            if (validateAndSave()) {
                              isApiCallService = true;
                            }

                            if (isApiCallService) {
                              await loadDetails();
                              LoadingOverlay loadingOverlay =
                                  LoadingOverlay.of(context);
                              requestModel.countrycode =
                                  countryinput == 'default'
                                      ? '+93'
                                      : countryinput;
                              requestModel.phone = phoneinput;
                              requestModel.latitude = user_latitude;
                              requestModel.longitude = user_longitude;
                              requestModel.location = user_location;
                              loadingOverlay.show();
                              Registration registerService = new Registration();

                              registerService
                                  .register(requestModel)
                                  .then((value) async {
                                loadingOverlay.hide();
                                if (value != null) {
                                  isApiCallService = false;
                                  if (value.status.isNotEmpty) {
                                    print(value.message);
                                    print(value.data.userId);
                                    if (value.status == "success") {
                                      await updateSharedPref();
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        print(
                                            'signuppage/otopverificationpage');
                                        return OtpVerificationPage(
                                          countryCode: countryinput,
                                          phone: phoneinput,
                                        );
                                      }));
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text(value.message),
                                        duration: const Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      print(value.message);
                                    }
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(value.message),
                                      duration: const Duration(seconds: 1),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    print(value.message);
                                  }
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('Something went wrong'),
                                    duration: const Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Color(0xff015272),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SFUIDisplay",
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              "or Continue With",
                              style: TextStyle(
                                  fontFamily: "SFUIDisplay",
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    print('signuppage/PhoneNumberPage');
                                    return PhoneNumberPage();
                                  }
                                          //AuthenticateScreenWrapper(true),
                                          ));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 12, bottom: 12, right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(textColor),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/phone.svg",
                                        color: Color(textColor),
                                        height: 17,
                                      ),
                                      //Image.asset("assets/images/facebook2.png",

                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Phone  ",
                                        style: TextStyle(
                                          color: Color(0xff999898),
                                          fontFamily: "SFUIDisplay",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  // SignInWithFacebook signInFB =
                                  //     SignInWithFacebook();
                                  // FacebookModel facebookModel =
                                  //     await signInFB.signIn();
                                  // bool isSuccess = await FacebookAdd()
                                  //     .facebookAdd(facebookModel);
                                  // //Todo add firebase signup in next page
                                  // isSuccess
                                  //     ? Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 PhoneNumberPage()))
                                  //     : () {};
                                  showToast('Feature not available yet', true);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 12, bottom: 12, right: 5, left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(textColor),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/facebooksvg.svg',
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                          color: Color(0xff999898),
                                          fontFamily: "SFUIDisplay",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Color(0xff999898),
                                  fontFamily: "SFUIDisplay",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    print('signuppage/authentication');
                                    return Authenticate();
                                  }));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Color(textColor),
                                      fontFamily: "SFUIDisplay",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 60,),
                        //
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         color: Color(greyColor),
                        //         height: 1.5,
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //
                        //     Container(
                        //       child: Text("or continue with",style: TextStyle(fontFamily: "SFUIDisplay",
                        //           color: Color(textColor)
                        //       ),
                        //
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //
                        //     Expanded(
                        //       child: Container(
                        //         color: Color(greyColor),
                        //         height: 1.5,
                        //       ),
                        //     ),
                        //
                        //
                        //   ],
                        // ),
                        // SizedBox(height: 10,),

                        // Row(
                        //   children: [
                        //
                        //
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.only(top: 15,bottom: 15,right: 5,left: 5),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: Color(greyColor),
                        //             ),
                        //             borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //
                        //             SvgPicture.asset(
                        //               'assets/images/googlesvg.svg',
                        //             ),
                        //             //Image.asset("assets/images/facebook2.png",
                        //
                        //             SizedBox(width: 7,),
                        //             Text("Google",style: TextStyle(color: Color(textColor),fontFamily: "SFUIDisplay",),),
                        //
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 5,),
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.only(top: 15,bottom: 15,right: 5,left: 5),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: Color(greyColor),
                        //             ),
                        //             borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             SvgPicture.asset(
                        //               'assets/images/facebooksvg.svg',
                        //             ),
                        //             SizedBox(width: 7,),
                        //             Text("Facebook",style: TextStyle(color: Color(textColor),fontFamily: "SFUIDisplay",),),
                        //
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 5,),
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.only(top: 15,bottom: 15,right: 5,left: 5),
                        //         decoration: BoxDecoration(
                        //             border: Border.all(
                        //               color: Color(greyColor),
                        //             ),
                        //             borderRadius: BorderRadius.circular(16)
                        //         ),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             SvgPicture.asset(
                        //               'assets/images/phonesvg.svg',
                        //             ),
                        //             SizedBox(width: 7,),
                        //             Text("Phone",style: TextStyle(color: Color(textColor),fontFamily: "SFUIDisplay",),),
                        //
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Align(
                        //   alignment: Alignment.center,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "Already have an account? ",
                        //         style: TextStyle(color: Color(textColor),fontFamily: "SFUIDisplay",),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).push(
                        //             MaterialPageRoute(builder: (_) => SignInPage()),
                        //           );
                        //         },
                        //         child: Text(
                        //           "Sign in now",
                        //           style: TextStyle(color: Color(pinkColor),fontFamily: "SFUIDisplay",),
                        //         ),
                        //       ),
                        //
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Widget buildSelectDate() {
    return InkWell(
      onTap: () {
        print("date picker selected");
        // show timer picker dialog
        showDatePickerDialog();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 58,
              decoration: BoxDecoration(
                border: Border.all(color: Color(borderColor)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      selectedDate,
                      style: TextStyle(
                          fontFamily: 'myfonts',
                          color: Color(0xff999898),
                          fontSize: 13),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset("assets/images/calenderp.png"))
                  //SvgPicture.asset(
                  //   'assets/images/double_arrow.svg',
                  //   color: Color(greyColor),
                  //   width: 12,
                  //   height: 12,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show date picker dialog
  Future<Null> showDatePickerDialog() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
    );
    if (picked != null) {
      print(picked.toString());
      setState(() {
        selectedDate = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
              requestModel.gender = value;
              print(requestModel.gender);
            });
          },
        ),
        Text(title)
      ],
    );
  }

// void saveDate()
// {
//   var firebaseUser =  FirebaseAuth.instance.currentUser;
//   firestoreInstance.collection("users").document(firebaseUser.uid).set(
//       {
//         "name" : "john",
//         "age" : 50,
//         "email" : "example@example.com",
//         "address" : {
//           "street" : "street 24",
//           "city" : "new york"
//         }
//       }).then((_){
//     print("success!");
//   });
// }
// Future<Map<String, double>> _getLocation() async {
//   var currentLocation = <String, double>{};
//   try {
//     currentLocation = (await location.getLocation()) as Map<String, double>;
//   } catch (e) {
//     currentLocation = null;
//   }
//   return currentLocation;
// }

//   void showPlacePicker() async {
//     LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) =>
//             PlacePicker("AIzaSyCxa093hAaUT4LY1p_6xNJHxSWO47cjn6Q"
//                 //"AIzaSyCmknnyYQWorOm6Mmi2oFKIzj3fgEsZYpY",
//                 //displayLocation: customLocation,
//                 )));
//
//     // Handle the result in your way
//     locationController.text = result.city.name;
//     print("Result Location: ");
//     print(result.city.name);
//     location = result.city.name;
//     requestModel.location = result.city.name;
//     print(requestModel.location);
//     print("Latitude: ");
//     requestModel.latitude = result.latLng.latitude.toString();
//     print(requestModel.latitude);
//     print("Longitude: ");
//     requestModel.longitude = result.latLng.longitude.toString();
//     print(requestModel.longitude);
//   }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
