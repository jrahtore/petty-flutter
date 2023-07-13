import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final txt;
  final onprs;
  final clr;
  const CustomTextButton({

    this.txt,
    this.onprs,
     this.clr,
  }) ;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onprs,
      child: Text(txt, style: TextStyle(fontSize: 16,color: clr, fontFamily: 'SFUIDisplay', fontWeight: FontWeight.bold),),
    );
  }
}


// class MyStatelessWidget extends StatelessWidget {
//   Color _textColor = Colors.green;

//   void _changeTextColor() {
//     _textColor = Colors.yellow;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _changeTextColor();
//       },
//       child: TextButton(
//         child: Text(
//           'Press me!',
//           style: TextStyle(
//             color: _textColor,
//             fontSize: 20,
//           ),
//         ),
//         onPressed: null,
//       ),
//     );
//   }
// }
