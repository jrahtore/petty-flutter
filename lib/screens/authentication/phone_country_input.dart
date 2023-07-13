import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petty_app/screens/phone_number/src/country.dart';
import 'package:petty_app/screens/phone_number/src/phone_service.dart';
import 'package:petty_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneCountryInput extends StatefulWidget {
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

  PhoneCountryInput(
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
  _PhoneCountryInputState createState() => _PhoneCountryInputState();
}

class _PhoneCountryInputState extends State<PhoneCountryInput> {
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
  InputDecoration decoration;
  Widget dropdownIcon;
  InputBorder border;
  String countryinput = "";
  String phoneinput = "";

  _PhoneCountryInputState();

  final phoneTextController = TextEditingController();

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
    phoneTextController.addListener(_validatePhoneNumber);
    phoneTextController.text = widget.initialPhoneNumber;
    phoneinput = "";
    countryinput = "default";

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
    prefs.setString("phoneinput", phoneinput);
    prefs.setString("countryinput", countryinput);
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
                      countryinput = selectedItem.dialCode;
                      print("Changed" + countryinput);
                    });
                    _validatePhoneNumber();
                  },
                  items: itemList
                      .map<DropdownMenuItem<Countryy>>((Countryy value) {
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
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (input) => {
                  setState(() {
                    phoneinput = input;
                    resetDetails();
                  }),
                },
                controller: phoneTextController,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Phone number cannot be empty";
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: decoration ??
                    InputDecoration(
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
                      hintText: hintText,
                      labelText: labelText,
                      errorText: hasError ? null : null,
                      errorStyle: errorStyle ?? null,
                      labelStyle: labelStyle,
                      errorMaxLines: errorMaxLines ?? 3,
                      //border: border ?? null,
                    ),
              ),
            ),
          ]),
    );
  }
}
