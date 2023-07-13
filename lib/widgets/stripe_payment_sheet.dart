import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_cvc_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:petty_app/component/pack_details.dart';

import '../component/payment_controller.dart';
import '../utils/animated_check.dart';

enum AnimationState { isLoading, isText, isAnimation }

class StripePaymentCard extends StatefulWidget {
  PaymentTypes paymentTypes = PaymentTypes.premium1month;
  Function(bool) isSuccess;
  double discount;
  StripePaymentCard(this.paymentTypes, {Key key, this.isSuccess, this.discount})
      : super(key: key);

  @override
  State<StripePaymentCard> createState() => _StripePaymentCardState();
}

class _StripePaymentCardState extends State<StripePaymentCard> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();
  var _isValidate = false;
  final _formKey = GlobalKey<FormState>();
  AnimationState _animationState = AnimationState.isText;
  bool isPaymentSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  String fullNameValidate(String fullName) {
    String pattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(pattern);
    if (fullName.length == 0) {
      return 'Please enter full name';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid full name';
    }
    return null;
  }

  String numberValidate(String number) {
    String pattern = r'^[0-9]+$';
    RegExp regExp = new RegExp(pattern);
    if (number.length == 0) {
      return 'Please enter a valid number';
    } else if (!regExp.hasMatch(number)) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String cardNumberValidate(String number) {
    String pattern = r'^[0-9 ]+$';
    RegExp regExp = new RegExp(pattern);
    if (number.length == 0) {
      return 'Please enter a valid number';
    } else if (!regExp.hasMatch(number)) {
      return 'Please enter a valid number';
    }
    return null;
  }

  String dateValidate(String number) {
    String pattern = r'^[0-9/]+$';
    RegExp regExp = new RegExp(pattern);
    if (number.length == 0) {
      return 'Please enter a valid date';
    } else if (!regExp.hasMatch(number)) {
      return 'Please enter a valid date';
    }
    return null;
  }

  checkFieldIsNotEmpty() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _cardNumberController.text.isNotEmpty &&
        _expiryDateController.text.isNotEmpty &&
        _cvcController.text.isNotEmpty) {
      setState(() {});
      return true;
    }
    return false;
  }

  getAnimationWidget() {
    if (_animationState == AnimationState.isText) {
      return Text(
        () {
          String amount = ((PackList().getPaymentAmount(widget.paymentTypes)) *
                  (1 - widget.discount / 100))
              .toString();
          return 'Pay \$${amount.substring(0, amount.indexOf('.') + 3)}';
        }(),
        style: TextStyle(
            color: _formKey.currentState == null ||
                    !_formKey.currentState.validate()
                ? Colors.white54
                : Colors.white),
      );
    } else if (_animationState == AnimationState.isLoading) {
      return SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Colors.white54,
        ),
      );
    } else {
      return AnimatedCheck(isPaymentSuccess, (value) {
        print('value bool animation complete = ' + value.toString());
        if (value)
          setState(() {
            _animationState = AnimationState.isText;
            Get.back();
            widget.isSuccess(isPaymentSuccess);
            isPaymentSuccess = false;
          });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                child: Text(
                  'Add your payment information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 18.0),
                child: Text('Card information'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      onChanged: (value) => checkFieldIsNotEmpty(),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        counterText: '',
                      ),
                      autovalidateMode: _isValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      maxLength: 15,
                      validator: (value) => fullNameValidate(value),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      onChanged: (value) => checkFieldIsNotEmpty(),
                      autovalidateMode: _isValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator:
                          ValidationBuilder().email().maxLength(50).build(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card number',
                        counterText: '',
                        suffixIcon: Icon(FontAwesomeIcons.creditCard),
                      ),
                      inputFormatters: [
                        CreditCardNumberInputFormatter(),
                      ],
                      onChanged: (value) => checkFieldIsNotEmpty(),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: _isValidate
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      validator: (value) => cardNumberValidate(value),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => checkFieldIsNotEmpty(),
                            controller: _expiryDateController,
                            keyboardType: TextInputType.number,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 5,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'MM / YY',
                              counterText: '',
                            ),
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              CreditCardExpirationDateFormatter(),
                            ],
                            validator: (value) => dateValidate(value),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => checkFieldIsNotEmpty(),
                            controller: _cvcController,
                            keyboardType: TextInputType.number,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 3,
                            inputFormatters: [
                              CreditCardCvcInputFormatter(),
                            ],
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) => numberValidate(value),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVC',
                              counterText: '',
                              suffixIcon: Image.asset(
                                'assets/images/cvv.png',
                                scale: 2.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isValidate = true;
                          });

                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _animationState = AnimationState.isLoading;
                            });
                            isPaymentSuccess = await PaymentBrain()
                                .makeSubscription(
                                    context,
                                    widget.paymentTypes,
                                    _cardNumberController.text
                                        .replaceAll(' ', ''),
                                    _expiryDateController.text.substring(0, 2),
                                    _expiryDateController.text.substring(3, 5),
                                    _cvcController.text);

                            setState(() {
                              _animationState = AnimationState.isAnimation;
                            });
                          }
                        },
                        child: getAnimationWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
