import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/petty_shared_pref.dart';
import '../utils/urls.dart';
import 'pack_details.dart';

enum PaymentTypes {
  premium1month,
  premium3month,
  premium6month,
  pettypass1pack,
  rewind1time,
  pettypass5pack,
  pettypass10pack,
  rewind1month,
  rewind3month,
  rewind6month,
  superpetty1month,
  superpetty3month,
  superpetty6month,
  unlock1time,
}

class PaymentBrain {
  Map<String, dynamic> paymentIntentData;
  String userId, token, mobile;
  PaymentTypes paymentTypesClassVariable;
  PackList packList = PackList();
  Map<String, dynamic> pack = {};
  final client = http.Client();
  static Map<String, String> headers = {
    // 'Authorization': 'Bearer sk_test_oxXvIoTc9ESlA5gMVdO4Xnif00fLKFSNJE',
    'Authorization': 'Bearer sk_live_CwZJ5XXXdnRngWTMzLHtRVYR00rfnhkxpG',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  SharedPreferences prefs;

  createPaymentIntent(String currency, String userId) async {
    try {
      pack = packList.getPack(paymentTypesClassVariable);
      String amountInPaise =
          (double.parse(pack['amount']) * 100.0).round().toString();
      Map<String, dynamic> body = {
        'amount': amountInPaise,
        'currency': currency,
        'payment_method_types[]': 'card',
        'statement_descriptor': userId,
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: headers);
      print(response.body);
      return jsonDecode(response.body.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> makePayment(
      BuildContext context, PaymentTypes paymentTypes) async {
    try {
      paymentTypesClassVariable = paymentTypes;
      await getUserIdAndToken();
      paymentIntentData = await createPaymentIntent('USD', 'user $userId');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          applePay : true,
          googlePay: true,
          style: ThemeMode.dark,
          merchantCountryCode: 'IN',
          merchantDisplayName: 'petty',
        ),
      );
      displayPaymentSheet(context);
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  getUserIdAndToken() async {
    prefs = await SharedPreferences.getInstance();
    userId = PettySharedPref.getUserId(prefs);
    token = PettySharedPref.getAccessToken(prefs);
    mobile =
        '${PettySharedPref.getUserCountryCode(prefs)}${PettySharedPref.getUserMobileNumber(prefs)}';
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntentData = null;
      bool isServerUpdated = await updatePaymentInServer(context);

      showSnackBar(context, isServerUpdated);
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('cancelled'),
        ),
      );
    }
  }

  Future<bool> updatePaymentInServer(BuildContext context) async {
    try {
      if (pack.isEmpty) {
        pack = packList.getPack(paymentTypesClassVariable);
      }
      Map<String, dynamic> queryparameters = {
        'pack_type': pack['duration'],
        'subscrptn_type': pack['subscrptn_type'],
        'token': PettySharedPref.getAccessToken(prefs),
        'user_id': PettySharedPref.getUserId(prefs)
      };
      var url =
          Uri.https(baseUrl, '/pettyapp/api/add_payment', queryparameters);
      final response = await http.post(url, headers: {
        "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
      });
      if (response.statusCode == 200) {
        var items = json.decode(response.body) != null
            ? json.decode(response.body)
            : null;
        print('items updated in category page + $items');

        return true;
      } else {
        print(json.decode(response.body)['message']);
        final snackBar = SnackBar(
            content: Text('Server is busy'),
            duration: const Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('items error');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> makeSubscription(BuildContext context, PaymentTypes paymentTypes,
      cardNumber, expMonth, expYear, cvc) async {
    print('subscription called');
    paymentTypesClassVariable = paymentTypes;
    await getUserIdAndToken();
    await _createCustomer();
    final _paymentMethod = await _createPaymentMethod(
        number: cardNumber, expMonth: expMonth, expYear: expYear, cvc: cvc);
    await _attachPaymentMethod(_paymentMethod['id'], '${userId}');
    await _updateCustomer(_paymentMethod['id'], '${userId}');
    return await _createSubscriptions('${userId}', paymentTypes, context);
  }

  Future<Map<String, dynamic>> _createCustomer() async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'name': 'user$userId',
        'id': '${userId}',
        'phone': '$mobile',
      },
    );
    if (response.statusCode == 200) {
      print('user created');
      return json.decode(response.body);
    }
  }

  Future<Map<String, dynamic>> _createPaymentMethod(
      {String number, String expMonth, String expYear, String cvc}) async {
    final String url = 'https://api.stripe.com/v1/payment_methods';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'type': 'card',
        'card[number]': '$number',
        'card[exp_month]': '$expMonth',
        'card[exp_year]': '$expYear',
        'card[cvc]': '$cvc',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
    }
  }

  Future<Map<String, dynamic>> _attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    final String url =
        'https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'customer': customerId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to attach PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> _updateCustomer(
      String paymentMethodId, String customerId) async {
    final String url = 'https://api.stripe.com/v1/customers/$customerId';

    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to update Customer.';
    }
  }

  Future<bool> _createSubscriptions(String customerId,
      PaymentTypes paymentTypes, BuildContext context) async {
    final String url = 'https://api.stripe.com/v1/subscriptions';
    String priceId;
    if (paymentTypes == PaymentTypes.premium1month) {
      priceId = 'price_1KvIJ5HZg0JBFQo2jVvsI7vY';
    } else if (paymentTypes == PaymentTypes.premium3month) {
      priceId = 'price_1KvIJpHZg0JBFQo2d3vNFkvC';
    } else {
      priceId = 'price_1KvJodHZg0JBFQo2BDGeUav5';
    }

    Map<String, dynamic> body = {
      'customer': customerId,
      'items[0][price]': priceId,
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      print('subscription response = ${response.body}');
      bool isServerUpdated = await updatePaymentInServer(context);
      showSnackBar(context, isServerUpdated);
      return isServerUpdated;
    } else {
      print(json.decode(response.body));
      return false;
    }
  }

  void showSnackBar(context, isServerUpdated) {
    if (isServerUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment Successful'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment Failed'),
        ),
      );
    }
  }
}
