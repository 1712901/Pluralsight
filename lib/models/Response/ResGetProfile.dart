import 'dart:convert';

import 'package:Pluralsight/models/AccountInf.dart';

ResGetProfile resGetProfileFromJson(String str) => ResGetProfile.fromJson(json.decode(str));

String resGetProfileToJson(ResGetProfile data) => json.encode(data.toJson());

class ResGetProfile {
    ResGetProfile({
        this.message,
        this.userInfo,
    });

    String message;
    UserInfo userInfo;

    factory ResGetProfile.fromJson(Map<String, dynamic> json) => ResGetProfile(
        message: json["message"],
        userInfo: UserInfo.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": userInfo.toJson(),
    };
}