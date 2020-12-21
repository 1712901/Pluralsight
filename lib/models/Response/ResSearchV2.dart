// To parse this JSON data, do
//
//     final resSearchV2 = resSearchV2FromJson(jsonString);

import 'dart:convert';

import 'package:Pluralsight/models/Response/ResGetTopSell.dart';

ResSearchV2 resSearchV2FromJson(String str) => ResSearchV2.fromJson(json.decode(str));

String resSearchV2ToJson(ResSearchV2 data) => json.encode(data.toJson());

class ResSearchV2 {
    ResSearchV2({
        this.message,
        this.payload,
    });

    String message;
    Payload payload;

    factory ResSearchV2.fromJson(Map<String, dynamic> json) => ResSearchV2(
        message: json["message"],
        payload: Payload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": payload.toJson(),
    };
}

class Payload {
    Payload({
        this.courses,
        this.instructors,
    });

    Courses courses;
    Instructors instructors;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        courses: Courses.fromJson(json["courses"]),
        instructors: Instructors.fromJson(json["instructors"]),
    );

    Map<String, dynamic> toJson() => {
        "courses": courses.toJson(),
        "instructors": instructors.toJson(),
    };
}

class Courses {
    Courses({
        this.data,
        this.totalInPage,
        this.total,
    });

    List<CourseInfor> data;
    int totalInPage;
    int total;

    factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        data: List<CourseInfor>.from(json["data"].map((x) => CourseInfor.fromSearchV2Json(x))),
        totalInPage: json["totalInPage"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalInPage": totalInPage,
        "total": total,
    };
}

class Instructors {
    Instructors({
        this.data,
        this.totalInPage,
        this.total,
    });

    List<InstructorSearchV2> data;
    int totalInPage;
    int total;

    factory Instructors.fromJson(Map<String, dynamic> json) => Instructors(
        data: List<InstructorSearchV2>.from(json["data"].map((x) => InstructorSearchV2.fromJson(x))),
        totalInPage: json["totalInPage"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalInPage": totalInPage,
        "total": total,
    };
}

class InstructorSearchV2 {
    InstructorSearchV2({
        this.id,
        this.name,
        this.avatar,
        this.numcourses,
    });

    String id;
    String name;
    String avatar;
    String numcourses;

    factory InstructorSearchV2.fromJson(Map<String, dynamic> json) => InstructorSearchV2(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        numcourses: json["numcourses"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "numcourses": numcourses,
    };
}
