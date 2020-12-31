import 'dart:convert';

import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';

ResInstructorsDetail resInstructorsDetailFromJson(String str) => ResInstructorsDetail.fromJson(json.decode(str));

String resInstructorsDetailToJson(ResInstructorsDetail data) => json.encode(data.toJson());

class ResInstructorsDetail {
    ResInstructorsDetail({
        this.message,
        this.instructorDetail,
    });

    String message;
    InstructorDetail instructorDetail;

    factory ResInstructorsDetail.fromJson(Map<String, dynamic> json) => ResInstructorsDetail(
        message: json["message"],
        instructorDetail: InstructorDetail.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": instructorDetail.toJson(),
    };
}

class InstructorDetail {
    InstructorDetail({
        this.id,
        this.userId,
        this.name,
        this.email,
        this.avatar,
        this.phone,
        this.major,
        this.intro,
        this.skills,
        this.createdAt,
        this.updatedAt,
        this.totalCourse,
        this.averagePoint,
        this.countRating,
        this.ratedNumber,
        this.soldNumber,
        this.courses,
    });

    String id;
    String userId;
    String name;
    String email;
    String avatar;
    String phone;
    String major;
    String intro;
    List<String> skills;
    DateTime createdAt;
    DateTime updatedAt;
    int totalCourse;
    double averagePoint;
    int countRating;
    int ratedNumber;
    int soldNumber;
    List<CourseInfor> courses;

    factory InstructorDetail.fromJson(Map<String, dynamic> json) => InstructorDetail(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        phone: json["phone"],
        major: json["major"],
        intro: json["intro"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        totalCourse: json["totalCourse"],
        averagePoint: json["averagePoint"].toDouble(),
        countRating: json["countRating"],
        ratedNumber: json["ratedNumber"],
        soldNumber: json["soldNumber"],
        courses: List<CourseInfor>.from(json["courses"].map((x) => CourseInfor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "phone": phone,
        "major": major,
        "intro": intro,
        "skills": List<dynamic>.from(skills.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "totalCourse": totalCourse,
        "averagePoint": averagePoint,
        "countRating": countRating,
        "ratedNumber": ratedNumber,
        "soldNumber": soldNumber,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}