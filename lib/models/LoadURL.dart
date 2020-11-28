import 'package:flutter/cupertino.dart';

class LoadURL extends ChangeNotifier {
  String url;
  LoadURL({this.url});
  void setUrl(String url) {
    this.url = url;
    notifyListeners();
  }
}
