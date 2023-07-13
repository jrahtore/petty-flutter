import 'package:flutter/material.dart';
import 'package:petty_app/widgets/photo_icon_stack.dart';

class SubscriptionAlert extends StatelessWidget {
  String name;
  String packDetail;
  String days;
  SubscriptionAlert({Key key, this.name, this.packDetail, this.days})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              width: double.infinity,
              color: Colors.black54,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.clear,
                color: Colors.white60,
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Container(
              child: Column(
                children: [
                  PhotoIconStack(
                    largeCircleColor: Colors.yellow,
                    smallCircleColor: Colors.yellow,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Hi! $name'),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Your ',
                      style: DefaultTextStyle.of(context).style.copyWith(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: packDetail,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(text: ' package is going to expire within '),
                        TextSpan(
                          text: '$days days.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Kindly upgrade your package.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Upgrade your package'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.yellow),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
