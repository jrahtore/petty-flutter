import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingOverlay {
  BuildContext _context;

  // Show overlay loader
  void hide() {
    Navigator.of(_context).pop();
  }

  // Show overlay loader
  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _FullScreenLoader();
        });
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0xff1E2661),
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink[200]),
        ),
      ),
    );
  }
}
