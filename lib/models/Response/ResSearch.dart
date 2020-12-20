import 'dart:convert';

import 'package:Pluralsight/models/Response/ResGetTopSell.dart';

ResSearch resSearchFromJson(String str) => ResSearch.fromJson(json.decode(str));

String resSearchToJson(ResSearch data) => json.encode(data.toJson());

class ResSearch {
    ResSearch({
        this.message,
        this.payload,
    });

    String message;
    Payload payload;

    factory ResSearch.fromJson(Map<String, dynamic> json) => ResSearch(
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
        this.count,
    });

    List<CourseInfor> courses;
    int count;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        courses: List<CourseInfor>.from(json["rows"].map((x) => CourseInfor.fromSearchJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(courses.map((x) => x.toJson())),
        "count": count,
    };
}