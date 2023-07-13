import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petty_app/component/payment_controller.dart';

import '../component/package_expire_alert_controller.dart';

class PackageExpiryScreen extends StatelessWidget {
  String image;
  String name;
  PackageExpiryScreen({Key key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff878787),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: IconButton(
                  color: Colors.white60,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 32,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 6,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30.0, right: 50, left: 30, top: 10),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                        radius: 62,
                        backgroundImage: image == null
                            ? AssetImage('assets/images/pettyone.png')
                            : NetworkImage(image),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      'assets/pack_expiry_alert.svg',
                    ),
                  )
                ],
              ),
              Expanded(
                child: SizedBox(),
                flex: 2,
              ),
              Text(
                'Hi! ${name ?? 'Cameron Williamson'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 3,
              ),
              FittedBox(
                child: RichText(
                  text: TextSpan(
                      text: 'Your',
                      style: TextStyle(
                        color: Colors.grey[350],
                        fontSize: 18,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: ' 1month/\$19.99',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' pack is going to expire\n'),
                        TextSpan(text: 'within '),
                        TextSpan(
                          text: '3 days',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '. Kindly upgrade your package'),
                      ]),
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 7,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    PackageExpiryController()
                        .gotoPackage(PaymentTypes.rewind1month, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Upgrade Your Package',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xfff7ec3a)),
                      elevation: MaterialStateProperty.all(0)),
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
