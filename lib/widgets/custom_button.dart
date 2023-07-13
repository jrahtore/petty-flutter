import 'package:flutter/material.dart';

class CustomBUtton extends StatelessWidget {
  final String BText;
  final color;
  final foreGcolor;
  final bgColor;
   final txtclr;
   final onprs;
  const CustomBUtton({
    @required this.txtclr,
    @required this.BText,
    @required this.color,
    @required this.foreGcolor,
    @required this.bgColor,
    @required this.onprs
    
  });

  @override
  Widget build(BuildContext context) {
    return Container( width: 150,
      child: ElevatedButton(  
        
           child: Text(
             BText.toUpperCase(),
             style: TextStyle(fontSize: 14, color: txtclr),
             
           ),
           style:  ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(foreGcolor),
             backgroundColor: MaterialStateProperty.all<Color>(bgColor),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder( 
                 borderRadius: BorderRadius.circular(20),
                 side: BorderSide(color: color)
               )
             )
           ),
           
           onPressed: onprs
      ),
    );
  }
}
