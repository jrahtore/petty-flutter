import 'package:flutter/material.dart';

class AnimatedCheck extends StatefulWidget {
  Function(bool) animationComplete;
  bool isPaymentSuccess = false;
  AnimatedCheck(this.isPaymentSuccess, this.animationComplete);
  @override
  _AnimatedCheckState createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  AnimationController scaleController;
  Animation<double> scaleAnimation;
  AnimationController checkController;
  Animation<double> checkAnimation;

  @override
  void initState() {
    super.initState();
    widget.animationComplete(false);
    scaleController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    scaleAnimation =
        CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
    checkController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    checkAnimation =
        CurvedAnimation(parent: checkController, curve: Curves.linear);
    checkController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scaleController.forward();
      }
    });
    checkController.forward();

    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.animationComplete(true);
      }
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 30;
    double iconSize = 25;

    return SizeTransition(
      sizeFactor: checkAnimation,
      axis: Axis.horizontal,
      axisAlignment: -1,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  color: widget.isPaymentSuccess ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                    height: circleSize,
                    width: circleSize,
                    child: widget.isPaymentSuccess
                        ? Icon(Icons.check, color: Colors.white, size: iconSize)
                        : Icon(Icons.close,
                            color: Colors.white, size: iconSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
