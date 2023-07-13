import 'package:flutter/material.dart';

class GradientOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle style;
  final Gradient gradient;
  final double thickness;

  const GradientOutlinedButton({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.style,
    this.gradient =
        const LinearGradient(colors: [Color(0xfffc267c), Color(0xffff7555)]),
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(thickness),
        child: OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        ),
      ),
    );
  }
}
