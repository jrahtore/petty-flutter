import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final txt;
  final clr;
  
  const BoldText({
    
   @required this.txt,
   this.clr,
    
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'SFUIDisplay',
          color: clr),
    );
  }
}