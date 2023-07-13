import 'package:flutter/cupertino.dart';
class ConnectionProvider extends ChangeNotifier {
  int index = 0;
  changeBorderColor(int x) {
    index = x;
    notifyListeners();
  }
}