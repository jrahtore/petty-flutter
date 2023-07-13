// import '../category_page.dart';
// import 'package:connectivity/connectivity.dart';
//import 'package:firebase_auth/firebase_auth.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petty_app/screens/authentication/sign_up_page.dart';
import 'package:petty_app/utils/constant.dart';

import '../welcome_page.dart';
// import 'file:///D:/MyFlutterProjects/petty/lib/screens/phone_number/phone_number.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage(this.toggleView);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool showPassword = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProgressEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordEditingController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  var subscription;
//  bool isProgressEnabled = false;
  // final AuthService _auth = AuthService();

  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Get.snackbar("ERROR", "No Internet Connection", colorText: Colors.red);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: isProgressEnabled
          ? buildProgressBar()
          : Form(
              key: _formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/welcomeback.svg',
                            height: 90,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 70,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          // keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            var reg = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (value.isEmpty) {
                              return "Email cannot be empty";
                            } else if (!reg.hasMatch(value)) {
                              return "Input valid email address";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: "example@gmail.com",
                            labelText: "Email",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Colors.grey,
                                fontSize: 12),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 70,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: !this.showPassword,
                          controller: _passwordEditingController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: showPassword
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color: !this.showPassword
                                          ? Colors.grey
                                          : Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: !this.showPassword
                                          ? Colors.grey
                                          : Colors.grey,
                                    ),
                              onPressed: () {
                                setState(() =>
                                    this.showPassword = !this.showPassword);
                              },
                            ),
                            fillColor: Colors.white,
                            // hintText: "Password",
                            labelText: "Password",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            hintStyle: TextStyle(
                                fontFamily: 'myfonts',
                                color: Colors.grey,
                                fontSize: 15),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          showAlertDialog(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new Container(
                              child: new Text(
                                "Forgot password ?",
                                style: TextStyle(
                                  color: Color(textColor),
                                  fontSize: 15,
                                  fontFamily: "SFUIDisplay",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomePage(),
                            ),
                          );
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
                              "Sign In",
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
                      Container(
                        child: Text(
                          "or Continue With",
                          style: TextStyle(
                              fontFamily: "SFUIDisplay", color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, right: 5, left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(textColor),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    "Phone    ",
                                    style: TextStyle(
                                      color: Color(0xff999898),
                                      fontFamily: "SFUIDisplay",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, right: 5, left: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(textColor),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xff999898),
                                fontFamily: "SFUIDisplay",
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SignUp(widget.toggleView),
                                  ),
                                );
                                print("SignUp Page Loading...");
                                widget.toggleView();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Color(textColor),
                                    fontFamily: "SFUIDisplay",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();

  Widget cButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Cancel"));
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Forgot Password"),
    content: TextFormField(
      decoration: InputDecoration(
        hintText: "example@gmail.com",
      ),
      controller: _controller,
      // maxLines: parameter == "Bio Data" ? 6 : 1,
    ),
    actions: [
      cButton,
      //okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
