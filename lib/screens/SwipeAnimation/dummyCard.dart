import 'package:flutter/material.dart';

Positioned cardDemoDummy(
    DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return new Positioned(
    //bottom: 00.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      margin: EdgeInsets.all(25),
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),

      //elevation: 4.0,
      child:  new Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: img,
              ),
            ),
            //   width: screenSize.width / 1.2 + cardWidth,
            //   height: screenSize.height / 2.2,
            //   decoration: new BoxDecoration(
            //     borderRadius: BorderRadius.circular(25),
            //     image: new DecorationImage(
            //       image: new ExactAssetImage('assets/images/jorge.png',),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // new Container(
            // new Container(
            //     width: screenSize.width / 1.2 + cardWidth,
            //     height: screenSize.height / 1.7 - screenSize.height / 2.2,
            //     alignment: Alignment.center,
            //     child: new Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         new FlatButton(
            //             padding: new EdgeInsets.all(0.0),
            //             onPressed: () {},
            //             child: new Container(
            //               height: 60.0,
            //               width: 130.0,
            //               alignment: Alignment.center,
            //               decoration: new BoxDecoration(
            //                 color: Colors.red,
            //                 borderRadius: new BorderRadius.circular(60.0),
            //               ),
            //               child: new Text(
            //                 "DON'T",
            //                 style: new TextStyle(color: Colors.white),
            //               ),
            //             )),
            //         new FlatButton(
            //             padding: new EdgeInsets.all(0.0),
            //             onPressed: () {},
            //             child: new Container(
            //               height: 60.0,
            //               width: 130.0,
            //               alignment: Alignment.center,
            //               decoration: new BoxDecoration(
            //                 color: Colors.cyan,
            //                 borderRadius: new BorderRadius.circular(60.0),
            //               ),
            //               child: new Text(
            //                 "I'M IN",
            //                 style: new TextStyle(color: Colors.white),
            //               ),
            //             ))
            //       ],
            //     ))

      ),
  );
}
