import 'package:flutter/material.dart';

class AlertBoxTextButton extends StatelessWidget {
  final txt;
  final IconImage;
  const AlertBoxTextButton({
    this.IconImage,
    this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Image.asset(
              IconImage,
              //'assets/images/smilie.png',
              height: 20,
              width: 20,
            ),
            // Icon(
            //   icon,
            //   size: 20,
            //   color:Color(0xffe4547f)
            //  // color: Color.fromARGB(255, 249, 149, 182),
            //   // R228 G90 B127
            // ),
            SizedBox(
              width: 15,
            ),
            Text(
              txt,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xffe4547f),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
