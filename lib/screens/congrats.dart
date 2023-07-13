


import 'package:flutter/material.dart';
import 'package:petty_app/screens/main_bottom_page.dart';
import 'package:petty_app/utils/constant.dart';


class Congrats extends StatefulWidget {
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {

  bool btnColor=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xffee1d7f3),
              Color(0xfffaf0f3),],
            center: Alignment(0, -1),

          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height:20),

              Container(
                  //color:Colors.deepPurpleAccent,
                  child: Image.asset("assets/torrance.png",
                    scale: 1.3,
                    //scale: 1.1,
                    //height:MediaQuery.of(context).size.height/2 ,
                  ),
                ),


              Text("Congrats!",style: TextStyle(
                color: Color(textColor),
                fontFamily: "SFUIDisplay",
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
              SizedBox(height: 10,),
              Text("You both Petty!",
                style: TextStyle(
                  color: Color(pinkColor),
                  fontFamily: "SFUIDisplay",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),

              ),
              SizedBox(height: 20,),

              Container(

                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        child: TextButton(
                          // elevation: 0,
                          onPressed: ()
                          {

                            setState(() {
                              btnColor=true;
                            });

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => MainBottomPage()));
                          },
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          // padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: btnColor? BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFF1C7E
                                    ),
                                    Color(0xffFF5F5D),



                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  //transform: GradientRotation(0.7853982),
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ):BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(greyColor),
                              ),

                              borderRadius: BorderRadius.circular(10.0)
                          ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                  minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Let's see or Lies ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: btnColor?Colors.white:Color(textColor),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SFUIDisplay",
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(15),

                      ),

                      Container(
                        height: 50.0,
                        child: ElevatedButton(
                          // elevation: 0,
                          onPressed: ()
                          {
                            setState(() {
                              btnColor=false;
                            });

                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (_) => PhoneNumberPage()),
                            //);
                          },
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          // padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration:btnColor? BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(greyColor),
                                ),

                                borderRadius: BorderRadius.circular(10.0)
                            ):BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFF1C7E
                                    ),
                                    Color(0xffFF5F5D),



                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  //transform: GradientRotation(0.7853982),
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                  minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Continue being Petty",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: btnColor?Color(textColor):Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SFUIDisplay",
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.only(left: 15,right: 15),


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
