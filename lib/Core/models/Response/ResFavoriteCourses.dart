import 'dart:convert';

import 'package:Pluralsight/Core/models/FavoriteCourse.dart';

ResFavoriteCourses resFavoriteCoursesFromJson(String str) => ResFavoriteCourses.fromJson(json.decode(str));

String resFavoriteCoursesToJson(ResFavoriteCourses data) => json.encode(data.toJson());

class ResFavoriteCourses {
    ResFavoriteCourses({
        this.message,
        this.favoriteCourse,
    });

    String message;
    List<FavoriteCourse> favoriteCourse;

    factory ResFavoriteCourses.fromJson(Map<String, dynamic> json) => ResFavoriteCourses(
        message: json["message"],
        favoriteCourse: List<FavoriteCourse>.from(json["payload"].map((x) => FavoriteCourse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": List<dynamic>.from(favoriteCourse.map((x) => x.toJson())),
    };
}