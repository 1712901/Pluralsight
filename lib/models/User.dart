import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  final int ID = 1;
  String name = '1712901';
  String email = "1712901@gmail.com";
  final String userName = "1712901";
  final String password = "1712901";
  bool isAuthorization = false;
  List<int> followAuthors = [];
  bool checkAuthorization({String userName, String password}) {
    if (userName.compareTo(this.userName) == 0 &&
        password.compareTo(this.password) == 0) {
      isAuthorization = true;
      return true;
    }
    return false;
  }

  void addFollow(int idAuthor) {
    if (!followAuthors.contains(idAuthor)) followAuthors.add(idAuthor);
    notifyListeners();
  }

  void removeFollow(int idAuthor) {
    if (followAuthors.contains(idAuthor)) followAuthors.remove(idAuthor);
    notifyListeners();
  }

  bool isFollow(int idAuthor) {
    return followAuthors.contains(idAuthor);
  }

  void setProfile({String name, String email}) {
    this.name = name;
    this.email = email;
  }

  void logout() {
    this.isAuthorization = false;
    notifyListeners();
  }
}
