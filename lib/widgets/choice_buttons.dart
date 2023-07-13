import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String BText;
  final color;
  final onpress;
  final style;
  final BorderColor;
   
  const ChoiceButton({
    @required this.BText,
    this.color,
    @required this.onpress,
    this.style,
     this.BorderColor,
   
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 50),
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton( 
        clipBehavior: Clip.hardEdge,
        onPressed: onpress,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            BText,
            style: style,
            
          ),
        ),
        
        style: ElevatedButton.styleFrom( elevation: 0,
        side: BorderSide(color: BorderColor),
         // side: BorderSide(),
         primary: Colors.white,


          shape: StadiumBorder(),
          
        ),
      ),
    );
  }
}
