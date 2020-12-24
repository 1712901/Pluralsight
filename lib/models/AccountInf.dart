import 'dart:convert';

import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
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
  List<CourseInfor> recommendCourse = [];
  int offset = 0;

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

    this.recommendCourse.clear();
    offset = 0;
    notifyListeners();
  }

  void setToken({String token}) {
    this.token = token;
    notifyListeners();
  }

  List<CourseInfor> getRecommendCourse() {
    return this.recommendCourse;
  }

  void setCommendCourse({List<CourseInfor> course, int offset}) {
    this.recommendCourse.addAll(course);
    this.offset = offset;
    notifyListeners();
  }
}

class UserInfo {
  UserInfo(
      {this.id,
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
      this.facebookId,
      this.googleId,
      this.password,
      this.point});

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
  int point;
  dynamic facebookId;
  String googleId;

  String password;

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

  factory UserInfo.fromJsonGetdetailCourse(Map<String, dynamic> json) =>
      UserInfo(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
        name: json["name"],
        favoriteCategories:
            List<String>.from(json["favoriteCategories"].map((x) => x)),
        point: json["point"],
        phone: json["phone"] == null ? null : json["phone"],
        type: json["type"],
        facebookId: json["facebookId"],
        googleId: json["googleId"],
        isDeleted: json["isDeleted"],
        isActivated: json["isActivated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
