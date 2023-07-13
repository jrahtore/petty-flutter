import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petty_app/api/terms_of_use.dart';
import 'package:petty_app/widgets/premium_pack_card.dart';
import 'package:petty_app/widgets/stripe_payment_sheet.dart';

import '../api/package_price_api.dart';
import '../component/pack_details.dart';
import '../component/payment_controller.dart';

enum ColorCarousal {
  RED,
  YELLOW,
}

class GoPremiumPkgs extends StatefulWidget {
  bool isFromCategory;
  double discount;
  GoPremiumPkgs({this.isFromCategory = false, this.discount = 0});
  @override
  _GoPremiumPkgsState createState() => _GoPremiumPkgsState();
}

class _GoPremiumPkgsState extends State<GoPremiumPkgs> {
  int currentImagePosition = 0;
  bool check = true;
  Map<String, dynamic> paymentIntentData;
  PaymentTypes paymentTypes = PaymentTypes.premium1month;
  ColorCarousal colorCarousal = ColorCarousal.YELLOW;
  bool isTextWhite = true;
  final _packList = PackList();
  bool isLoading = false;

  getColorFromCarousal() {
    if (currentImagePosition % 2 == 0) {
      colorCarousal = ColorCarousal.YELLOW;
      isTextWhite = false;
    } else if (currentImagePosition % 2 == 1) {
      //todo change color to red if needed
      colorCarousal = ColorCarousal.YELLOW;
      isTextWhite = true;
    }
    if (colorCarousal == ColorCarousal.YELLOW) {
      return Colors.yellow;
    }
    return Color(0xffED1941);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPriceDetails();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/packagesbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image.asset("assets/packagesbg.png"),

                SizedBox(
                  height: h * 0.023,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(left: w * 0.03, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(h * 0.05),
                            color: Colors.transparent),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),

                SizedBox(
                  height: h * 0.016,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'BECOME',
                        textScaleFactor: h * 0.0012,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'SFUIDisplay'),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Expanded(
                            child: Container(
                              height: h * 0.0055,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(h * 0.0055 / 2),
                                color: getColorFromCarousal(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: getColorFromCarousal(),
                              fontSize: 30.0,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: w * 0.03,
                          ),
                          Expanded(
                            child: Container(
                              height: h * 0.0055,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(h * 0.0055 / 2),
                                color: getColorFromCarousal(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.04,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.015,
                ),
                SvgPicture.asset(
                  'assets/images/crownsvg.svg',
                  height: h * 0.16,
                  color: Colors.yellow,
                ),
                Container(child: buildSlider(h)),
                SizedBox(
                  height: h * 0.23,
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.051, right: w * 0.051),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.premium1month;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(w * 0.025),
                                  color:
                                      paymentTypes == PaymentTypes.premium1month
                                          ? Colors.white
                                          : Colors.transparent,
                                  border: paymentTypes ==
                                          PaymentTypes.premium1month
                                      ? Border.all(
                                          color: getColorFromCarousal(),
                                          width: 3)
                                      : Border.all(color: Colors.transparent)),
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : PremiumPackCard(
                                      month: 1,
                                      color: getColorFromCarousal(),
                                      amount: (_packList.getPaymentAmount(
                                                  PaymentTypes.premium1month) *
                                              (1 - (widget.discount / 100)))
                                          .toString(),
                                      paymentType: paymentTypes,
                                      requiredPaymentType:
                                          PaymentTypes.premium1month,
                                    ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.premium3month;
                              });
                            },
                            child: Container(
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      paymentTypes == PaymentTypes.premium3month
                                          ? Colors.white
                                          : Colors.transparent,
                                  border: paymentTypes ==
                                          PaymentTypes.premium3month
                                      ? Border.all(
                                          color: getColorFromCarousal(),
                                          width: 3)
                                      : Border.all(color: Colors.transparent)),
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Stack(
                                      children: [
                                        PremiumPackCard(
                                          month: 3,
                                          color: getColorFromCarousal(),
                                          amount: (_packList.getPaymentAmount(
                                                      PaymentTypes
                                                          .premium3month) *
                                                  (1 - (widget.discount / 100)))
                                              .toString(),
                                          paymentType: paymentTypes,
                                          requiredPaymentType:
                                              PaymentTypes.premium3month,
                                        ),
                                        paymentTypes ==
                                                PaymentTypes.premium3month
                                            ? Column(
                                                children: [
                                                  Container(
                                                    height: h * 0.035,
                                                    alignment: Alignment.center,
                                                    color: paymentTypes ==
                                                            PaymentTypes
                                                                .premium3month
                                                        ? getColorFromCarousal()
                                                        : Colors.transparent,
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(3),
                                                    child: Center(
                                                      child: FittedBox(
                                                        child: Text(
                                                          () {
                                                            double
                                                                amount1month =
                                                                _packList.getPaymentAmount(
                                                                        PaymentTypes
                                                                            .premium1month) *
                                                                    100 *
                                                                    3;
                                                            amount1month =
                                                                amount1month
                                                                        .truncate() /
                                                                    100.0;
                                                            double
                                                                amount3month =
                                                                _packList.getPaymentAmount(
                                                                        PaymentTypes
                                                                            .premium3month) *
                                                                    100;
                                                            amount3month =
                                                                amount3month
                                                                        .truncate() /
                                                                    100.0;
                                                            return 'Save ${((1 - (amount3month / amount1month)) * 100).round()}%';
                                                          }(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                paymentTypes = PaymentTypes.premium6month;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      paymentTypes == PaymentTypes.premium6month
                                          ? Colors.white
                                          : Colors.transparent,
                                  border: paymentTypes ==
                                          PaymentTypes.premium6month
                                      ? Border.all(
                                          color: getColorFromCarousal(),
                                          width: 3)
                                      : Border.all(color: Colors.transparent)),
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Stack(
                                      children: [
                                        PremiumPackCard(
                                          month: 6,
                                          color: getColorFromCarousal(),
                                          amount: (_packList.getPaymentAmount(
                                                      PaymentTypes
                                                          .premium6month) *
                                                  (1 - (widget.discount / 100)))
                                              .toString(),
                                          paymentType: paymentTypes,
                                          requiredPaymentType:
                                              PaymentTypes.premium6month,
                                        ),
                                        paymentTypes ==
                                                PaymentTypes.premium6month
                                            ? Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      color: paymentTypes ==
                                                              PaymentTypes
                                                                  .premium6month
                                                          ? getColorFromCarousal()
                                                          : Colors.white,
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: Center(
                                                        child: FittedBox(
                                                          child: Text(
                                                            () {
                                                              double
                                                                  amount1month =
                                                                  _packList.getPaymentAmount(
                                                                          PaymentTypes
                                                                              .premium1month) *
                                                                      100 *
                                                                      6;
                                                              amount1month =
                                                                  amount1month
                                                                          .truncate() /
                                                                      100.0;
                                                              double
                                                                  amount6month =
                                                                  _packList.getPaymentAmount(
                                                                          PaymentTypes
                                                                              .premium6month) *
                                                                      100;
                                                              amount6month =
                                                                  amount6month
                                                                          .truncate() /
                                                                      100.0;
                                                              return 'Save ${((1 - (amount6month / amount1month)) * 100).round()}%';
                                                            }(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(),
                                                    flex: 5,
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: h * 0.025,
                ),

                Container(
                  margin: EdgeInsets.only(left: w * 0.051, right: w * 0.051),
                  height: h * 0.057,
                  child: ElevatedButton(
                    // color: getColorFromCarousal(),
                    onPressed: () {
                      Get.bottomSheet(
                        StripePaymentCard(paymentTypes,
                            discount: widget.discount, isSuccess: (isSuccess) {
                          print('isSuccess = ' + isSuccess.toString());
                          if (isSuccess == true && widget.isFromCategory) {
                            Navigator.pop(context, 0);
                          }
                        }),
                        enterBottomSheetDuration: Duration(seconds: 1),
                        exitBottomSheetDuration: Duration(seconds: 1),
                        isScrollControlled: true,
                      );
                    },
                    // textColor: Colors.black,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "CONTINUE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(h * 0.057 / 2)),
                  ),
                ),

                SizedBox(
                  height: h * 0.025,
                ),

                Text(
                  "Recurring Billing, Cancel Anytime.",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: h * 0.025,
                ),
                Container(
                  margin: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Text(
                    "By tapping Continue, your payment will be charged to your "
                    "Google Play Account and your subscription will automatically"
                    " renew for the same package length at the same price until you"
                    " cancel in setting in the Google Play Store and you agree to our",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "SFUIDisplay",
                        fontSize: 13),
                    textScaleFactor: h * 0.001,
                  ),
                ),
                InkWell(
                  onTap: () {
                    TermsOfUseApiCall().apiCall(context);
                  },
                  child: Text(
                    "Terms of Use",
                    textScaleFactor: h * 0.001,
                    style: TextStyle(
                        color: Colors.yellow, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // build image slider
  Widget buildSlider(double h) {
    return SizedBox(
      height: h * 0.13,
      child: Carousel(
        images: [
          getPremiumDetail("assets/images/extrapetty.svg", "Get Noticed More",
              "Electrify your profile and be seen in your", "area for 30 min"),
          getPremiumDetail(
              "assets/images/superpetty.svg",
              "Let Them Know You are Interested",
              "5x the chance to be Liked more and",
              "matched with Super Likes"),
          getPremiumDetail("assets/images/extrapetty.svg", "Get Noticed More",
              "Electrify your profile and be seen in your", "area for 30 min"),

          // getPremiumDetail(
          //     "assets/images/removedpetty.svg",
          //     " If You Missed Something Go Back",
          //     "Get Unlimited Rewinds and Reverse",
          //     "Mistaken Passes"),
          // getPremiumDetail(
          //     "assets/images/starpetty.svg",
          //     " Let Them Know You Interested",
          //     "5x the chance to be Liked more and",
          //     "matched with Super Likes "),
          // getPremiumDetail(
          //     "assets/images/removepetty.svg",
          //     "Remove Interruptions",
          //     "Ads are turned off so you can experience",
          //     "being Petty more"),
        ],
        dotBgColor: Colors.transparent,
        dotIncreaseSize: h * 0.0015,
        dotColor: Colors.white24,
        // dotVerticalPadding: -h * 0.025,
        autoplayDuration: Duration(seconds: 10),
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

  Widget getPremiumDetail(
      String imgPath, String text1, String text2, String text3) {
    return FittedBox(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            text1,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            text3,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
        ],
      ),
    );
  }

  void getPriceDetails() async {
    if (PackList.packlist.isEmpty) {
      isLoading = true;
      await PackagePriceApi().packagePriceGet();
      setState(() {
        isLoading = false;
      });
    }
  }

// Future<bool> postData() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     List<Map<String, dynamic>> listOfMapNestedObjects = [];
//
//     for (var choice in selectedChoices) {
//       Map<String, dynamic> mapNestedObjects = {};
//       mapNestedObjects.putIfAbsent('id', () => choice);
//       listOfMapNestedObjects.add(mapNestedObjects);
//     }
//
//     print('map list = $listOfMapNestedObjects');
//     var jsonData = json.encode(listOfMapNestedObjects);
//     Map<String, dynamic> queryparameters = {
//       'user_cat_selections': jsonData,
//       'token': PettySharedPref.getAccessToken(prefs),
//       'user_id': PettySharedPref.getUserId(prefs)
//     };
//     var url = Uri.https(baseUrl, '/pettyapp/api/Category', queryparameters);
//     final response = await http.post(url, headers: {
//       "Authorization": "ZGVlcGFrOmp1ZTQ5ODl2czl2MmprNzZ0eDg3M2I4ZTUzZDRjMjc2"
//     });
//     if (response.statusCode == 200) {
//       var items = json.decode(response.body) != null
//           ? json.decode(response.body)
//           : [];
//       print('items updated in category page + $items');
//       return true;
//     } else {
//       print(json.decode(response.body)['message']);
//       final snackBar = SnackBar(
//           content: Text('Server is busy'),
//           duration: const Duration(seconds: 1));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       print('items error');
//       return false;
//     }
//   } catch (e) {
//     return false;
//   }
// }
}
