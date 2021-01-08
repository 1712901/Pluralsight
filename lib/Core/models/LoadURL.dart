import 'package:flutter/cupertino.dart';

class LoadURL extends ChangeNotifier {
  String url;
  LoadURL({this.url});
  void setUrl(String url) {
    this.url = url;
    notifyListeners();
  }

  bool isYotuber() {
    if (url.contains("youtube.com")) return true;
    return false;
  }
}
