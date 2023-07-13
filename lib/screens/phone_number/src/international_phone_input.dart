//library international_phone_input;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petty_app/api/otp_generation.dart';
import 'package:petty_app/models/otp_gen_model.dart';
import 'package:petty_app/screens/phone_number/src/phone_service.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:petty_app/widgets/loading_pop_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'country.dart';

class InternationalPhoneInput extends StatefulWidget {
  final void Function(String phoneNumber, String internationalizedPhoneNumber,
      String isoCode, String dialCode) onPhoneNumberChange;
  final String initialPhoneNumber;
  final String initialSelection;
  final String errorText;
  final String hintText;
  final String labelText;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final int errorMaxLines;
  final List<String> enabledCountries;
  final InputDecoration decoration;
  final bool showCountryCodes;
  final bool showCountryFlags;
  final Widget dropdownIcon;
  final InputBorder border;

  InternationalPhoneInput(
      {this.onPhoneNumberChange,
      this.initialPhoneNumber,
      this.initialSelection,
      this.errorText,
      this.hintText,
      this.labelText,
      this.errorStyle,
      this.hintStyle,
      this.labelStyle,
      this.enabledCountries = const [],
      this.errorMaxLines,
      this.decoration,
      this.showCountryCodes = true,
      this.showCountryFlags = true,
      this.dropdownIcon,
      this.border});

  static Future<String> internationalizeNumber(String number, String iso) {
    return PhoneService.getNormalizedPhoneNumber(number, iso);
  }

  @override
  _InternationalPhoneInputState createState() =>
      _InternationalPhoneInputState();
}

class _InternationalPhoneInputState extends State<InternationalPhoneInput> {
  Countryy selectedItem;
  List<Countryy> itemList = [];

  String errorText;
  String hintText;
  String labelText;

  TextStyle errorStyle;
  TextStyle hintStyle;
  TextStyle labelStyle;

  int errorMaxLines;

  bool hasError = false;
  bool showCountryCodes;
  bool showCountryFlags;
  OtpRequestModel otpRequestModel;
  bool isOTP = false;
  bool isButtonClickable = true;
  String userId;
  String phone;
  String countrycode;
  bool verify = false;
  bool isLoading = false;

  InputDecoration decoration;
  Widget dropdownIcon;
  InputBorder border;

  _InternationalPhoneInputState();

  final phoneTextController = TextEditingController();

  @override
  void dispose() {
    phoneTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    errorText = widget.errorText ?? 'Please enter a valid phone number';
    hintText = widget.hintText ?? '9524 524 008';
    labelText = widget.labelText;
    errorStyle = widget.errorStyle;
    hintStyle = widget.hintStyle;
    labelStyle = widget.labelStyle;
    errorMaxLines = widget.errorMaxLines;
    decoration = widget.decoration;
    showCountryCodes = widget.showCountryCodes;
    showCountryFlags = widget.showCountryFlags;
    dropdownIcon = widget.dropdownIcon;
    otpRequestModel = new OtpRequestModel(
      phone: "",
      countrycode: "",
    );
    userId = "-1";
    phone = "";
    countrycode = "";
    verify = false;

    phoneTextController.addListener(_validatePhoneNumber);
    phoneTextController.text = widget.initialPhoneNumber;

    _fetchCountryData().then((list) {
      Countryy preSelectedItem;

      if (widget.initialSelection != null) {
        preSelectedItem = list.firstWhere(
            (e) =>
                (e.code.toUpperCase() ==
                    widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection.toString()),
            orElse: () => list[0]);
      } else {
        preSelectedItem = list[0];
      }

      setState(() {
        itemList = list;
        selectedItem = preSelectedItem;
      });
    });

    super.initState();
  }

  resetDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
    prefs.setString("countrycode", countrycode);
    prefs.setString("userId", userId);
    prefs.setBool("verify", verify);
    // if (prefs.containsKey("phone")) {

    // } else {
    //   prefs.setString('phone', "null");
    // }
    // if (prefs.containsKey("countrycode")) {

    // } else {
    //   prefs.setString('countrycode', "null");
    // }
    // if (prefs.containsKey("userId")) {

    // }
  }

  _validatePhoneNumber() {
    String phoneText = phoneTextController.text;
    if (phoneText != null && phoneText.isNotEmpty) {
      PhoneService.parsePhoneNumber(phoneText, selectedItem.code)
          .then((isValid) {
        setState(() {
          hasError = !isValid;
        });

        if (widget.onPhoneNumberChange != null) {
          if (isValid) {
            PhoneService.getNormalizedPhoneNumber(phoneText, selectedItem.code)
                .then((number) {
              widget.onPhoneNumberChange(
                  phoneText, number, selectedItem.code, selectedItem.dialCode);
            });
          } else {
            widget.onPhoneNumberChange(
                '', '', selectedItem.code, selectedItem.dialCode);
          }
        }
      });
    }
  }

  Future<List<Countryy>> _fetchCountryData() async {
    var list = await DefaultAssetBundle.of(context)
        .loadString('assets/countries.json');
    List<dynamic> jsonList = json.decode(list);

    List<Countryy> countries =
        List<Countryy>.generate(jsonList.length, (index) {
      Map<String, String> elem = Map<String, String>.from(jsonList[index]);
      if (widget.enabledCountries.isEmpty) {
        return Countryy(
            name: elem['en_short_name'],
            code: elem['alpha_2_code'],
            dialCode: elem['dial_code'],
            flagUri: 'assets/flags/${elem['alpha_2_code'].toLowerCase()}.png');
      } else if (widget.enabledCountries.contains(elem['alpha_2_code']) ||
          widget.enabledCountries.contains(elem['dial_code'])) {
        return Countryy(
            name: elem['en_short_name'],
            code: elem['alpha_2_code'],
            dialCode: elem['dial_code'],
            flagUri: 'assets/flags/${elem['alpha_2_code'].toLowerCase()}.png');
      } else {
        return null;
      }
    });

    countries.removeWhere((value) => value == null);

    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(greyColor),
          ),
        ),
        // borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: DropdownButton<Countryy>(
                value: selectedItem,
                icon: Padding(
                  padding:
                      EdgeInsets.only(bottom: (decoration != null) ? 6 : 0),
                  child: dropdownIcon ??
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                ),
                onChanged: (Countryy newValue) {
                  setState(() {
                    selectedItem = newValue;
                    otpRequestModel.countrycode = newValue.dialCode;
                    //print(otpRequestModel.countrycode);
                  });
                  _validatePhoneNumber();
                },
                items:
                    itemList.map<DropdownMenuItem<Countryy>>((Countryy value) {
                  return DropdownMenuItem<Countryy>(
                    value: value,
                    child: Container(
                      //color:Colors.red,
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (showCountryFlags) ...[
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1),
                                child: Image.asset(
                                  value.flagUri,
                                  // width: 30.0,
                                  height: 23,
                                  fit: BoxFit.cover,

                                  //package: 'petty',
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle
                              // ),
                              margin: EdgeInsets.only(left: 5),
                            )
                          ],
                          if (showCountryCodes) ...[
                            SizedBox(width: 4),
                            Text(value.dialCode)
                          ]
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Flexible(
              child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (input) =>
                {otpRequestModel.phone = input, verify = false},
            controller: phoneTextController,
            decoration: decoration ??
                InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  hintText: hintText,
                  labelText: labelText,
                  errorText: hasError ? null : null,
                  hintStyle: hintStyle ?? null,
                  errorStyle: errorStyle ?? null,
                  labelStyle: labelStyle,
                  errorMaxLines: errorMaxLines ?? 3,
                  //border: border ?? null,
                ),
          )),
          ElevatedButton(
            child: Text(
              "Send",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              onPrimary: Color(0xff015272),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              onSurface: Color(0xff015272),
              padding:
                  EdgeInsets.only(top: 0.5, bottom: 0.5, left: 0.5, right: 0.5),
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
                      isOTP = true;
                      isButtonClickable = false;
                    });
                    if (isLoading) {
                      showLoadingIndicator("OTP being Send..");
                      apiCall();
                    } else {
                      hideOpenDialog();
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }

  void buttonClicked() async {
    Duration time = Duration(seconds: 60);
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

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }

  void showLoadingIndicator([String text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }

  void apiCall() {
    OtpGeneration otpGeneration = new OtpGeneration();
    otpGeneration.otpgen(otpRequestModel).then((value) {
      if (value != null) {
        setState(() {
          isOTP = false;
          isLoading = false;
          verify = true;
        });
        hideOpenDialog();
        if (value.status == "success") {
          phone = this.otpRequestModel.phone;
          countrycode = this.otpRequestModel.countrycode;
          userId = value.data.userId;
          verify = true;
          resetDetails();
          print(userId);
        } else {
          isButtonClickable = true;
          final snackBar = SnackBar(
              content: Text(value.message),
              duration: const Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(value.message);
        }
      }
    });
  }
}
