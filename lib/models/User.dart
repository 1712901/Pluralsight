import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  final int ID = 1;
  String name;
  final String userName = "1712901";
  final String password = "1712901";
  bool isAuthorization = false;
  bool checkAuthorization({String userName, String password}) {
    if (userName.compareTo(this.userName) == 0 &&
        password.compareTo(this.password) == 0) {
      isAuthorization = true;
      return true;
    }
    return false;
  }
}
