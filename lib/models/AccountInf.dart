import 'dart:convert';

import 'package:flutter/cupertino.dart';

AccountInf accountInfFromJson(String str) =>
    AccountInf.fromJson(json.decode(str));

String accountInfToJson(AccountInf data) => json.encode(data.toJson());

class AccountInf extends ChangeNotifier {
  AccountInf({
    this.userInfo,
    this.token,
  });
  UserInfo userInfo;
  String token;

  void setAcountInf(String body) {
    AccountInf accountInf = accountInfFromJson(body);
    this.userInfo = accountInf.userInfo;
    this.token = accountInf.token;
    notifyListeners();
  }

  void setUserInfor(UserInfo userInfo) {
    this.userInfo = userInfo;
  }

  factory AccountInf.fromJson(Map<String, dynamic> json) => AccountInf(
        userInfo: UserInfo.fromJson(json["userInfo"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userInfo": userInfo.toJson(),
        "token": token,
      };

  bool isAuthorization() {
    return this.token != null;
  }

  void logout() {
    this.token = null;
    notifyListeners();
  }

  void setToken({String token}) {
    this.token = token;
    notifyListeners();
  }
}

class UserInfo {
  UserInfo({
    this.id,
    this.email,
    this.avatar,
    this.name,
    this.favoriteCategories,
    this.phone,
    this.type,
    this.isDeleted,
    this.isActivated,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String email;
  String avatar;
  String name;
  List<String> favoriteCategories;
  String phone;
  String type;
  bool isDeleted;
  bool isActivated;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        avatar: json["avatar"],
        name: json["name"],
        favoriteCategories:
            List<String>.from(json["favoriteCategories"].map((x) => x)),
        phone: json["phone"],
        type: json["type"],
        isDeleted: json["isDeleted"],
        isActivated: json["isActivated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "avatar": avatar,
        "name": name,
        "favoriteCategories":
            List<dynamic>.from(favoriteCategories.map((x) => x)),
        "phone": phone,
        "type": type,
        "isDeleted": isDeleted,
        "isActivated": isActivated,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
