
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/screens/main_bottom_page.dart';
import 'package:petty_app/screens/utils.dart';


class MatchedPage extends StatefulWidget {
  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.1,
            child: Center(
              child: Image.asset(
                "assets/images/torrance.png",
                scale: 1,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Agens, 32",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Image.asset(
              "assets/images/congratulation.png",
              scale: 3,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MainBottomPage(),
                ),
              );
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Color(greyTransparent),
                //Color(bgColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Let's see if it's Truth or Lies",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MainBottomPage(),
                ),
              );
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Color(greyTransparent),
                //Color(bgColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "         Keep Being Petty        ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
