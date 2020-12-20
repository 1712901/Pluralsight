
import 'dart:convert';

ResGetIntructor resGetIntructorFromJson(String str) => ResGetIntructor.fromJson(json.decode(str));

String resGetIntructorToJson(ResGetIntructor data) => json.encode(data.toJson());

class ResGetIntructor {
    ResGetIntructor({
        this.message,
        this.intructor,
    });

    String message;
    List<Intructor> intructor;

    factory ResGetIntructor.fromJson(Map<String, dynamic> json) => ResGetIntructor(
        message: json["message"],
        intructor: List<Intructor>.from(json["payload"].map((x) => Intructor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": List<dynamic>.from(intructor.map((x) => x.toJson())),
    };
}

class Intructor {
    Intructor({
        this.id,
        this.payloadUserId,
        this.major,
        this.intro,
        this.skills,
        this.cumulativeTuition,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.userEmail,
        this.userAvatar,
        this.userName,
        this.userFavoriteCategories,
        this.userPoint,
        this.userPhone,
        this.userType,
        this.userIsDeleted,
        this.userIsActivated,
        this.userCreatedAt,
        this.userUpdatedAt,
    });

    String id;
    String payloadUserId;
    String major;
    String intro;
    List<String> skills;
    int cumulativeTuition;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;
    String userId;
    String userEmail;
    String userAvatar;
    String userName;
    List<dynamic> userFavoriteCategories;
    int userPoint;
    String userPhone;
    UserType userType;
    bool userIsDeleted;
    bool userIsActivated;
    DateTime userCreatedAt;
    DateTime userUpdatedAt;

    factory Intructor.fromJson(Map<String, dynamic> json) => Intructor(
        id: json["id"],
        payloadUserId: json["userId"],
        major: json["major"] == null ? null : json["major"],
        intro: json["intro"] == null ? null : json["intro"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        cumulativeTuition: json["cumulativeTuition"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["user.id"],
        userEmail: json["user.email"],
        userAvatar: json["user.avatar"],
        userName: json["user.name"],
        userFavoriteCategories: json["user.favoriteCategories"] == null ? null : List<dynamic>.from(json["user.favoriteCategories"].map((x) => x)),
        userPoint: json["user.point"],
        userPhone: json["user.phone"] == null ? null : json["user.phone"],
        userType: userTypeValues.map[json["user.type"]],
        userIsDeleted: json["user.isDeleted"],
        userIsActivated: json["user.isActivated"],
        userCreatedAt: DateTime.parse(json["user.createdAt"]),
        userUpdatedAt: DateTime.parse(json["user.updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": payloadUserId,
        "major": major == null ? null : major,
        "intro": intro == null ? null : intro,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "cumulativeTuition": cumulativeTuition,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user.id": userId,
        "user.email": userEmail,
        "user.avatar": userAvatar,
        "user.name": userName,
        "user.favoriteCategories": userFavoriteCategories == null ? null : List<dynamic>.from(userFavoriteCategories.map((x) => x)),
        "user.point": userPoint,
        "user.phone": userPhone == null ? null : userPhone,
        "user.type": userTypeValues.reverse[userType],
        "user.isDeleted": userIsDeleted,
        "user.isActivated": userIsActivated,
        "user.createdAt": userCreatedAt.toIso8601String(),
        "user.updatedAt": userUpdatedAt.toIso8601String(),
    };
}

enum UserType { INSTRUCTOR }

final userTypeValues = EnumValues({
    "INSTRUCTOR": UserType.INSTRUCTOR
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
