import 'package:Pluralsight/models/Course.dart';
import 'package:flutter/cupertino.dart';

class CourseListModel extends ChangeNotifier {
  final List<CourseModel> couserList = [
    new CourseModel(
        ID: 0,
        name: "Designing RESTful Web APIs",
        level: 1,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 150,
        category: 1,
        size: 150,
        tags: ["JAVA", "ANDROID", "MOBLIE","Angular"]),
    new CourseModel(
        ID: 1,
        name: "Angular Fundamenttals",
        level: 1,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 150,
        category: 1,
        size: 150,
        tags: ["Angular", "ANDROID", "IOS"]),
    new CourseModel(
        ID: 2,
        name: "C# Fundamenttals",
        level: 2,
        rating: 4.5,
        date: DateTime.now(),
        numberComment: 102,
        category: 1,
        size: 150,
        tags: [
          "OPP",
          "DESIGN PATTERNS",
        ]),
    new CourseModel(
        ID: 3,
        name: "Managing AWS Operation",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 10,
        category: 1,
        size: 150,
        tags: ["AWS","C++"]),
    new CourseModel(
        ID: 4,
        name: "Spring Framework",
        level: 2,
        rating: 4.5,
        date: DateTime.now(),
        numberComment: 110,
        category: 1,
        size: 150,
        tags: ["SPRING", "JAVA"]),
    new CourseModel(
        ID: 5,
        name: "Spring: The Big Picture",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 201,
        category: 2,
        size: 150,
        tags: ["Spring", "Java"]),
    new CourseModel(
        ID: 6,
        name: "Dependency Injection in APS.NET Core",
        level: 2,
        rating: 4.5,
        date: DateTime.now(),
        numberComment: 10,
        category: 2,
        size: 150,
        tags: ["C#", "APS.NET",".NET"]),
    new CourseModel(
        ID: 7,
        name: "Designing RESTful Web APIs",
        level: 3,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 152,
        category: 3,
        size: 150,
        tags: ["API","JavaScript"]),
    new CourseModel(
        ID: 8,
        name: "Node.js: The big Picture",
        level: 1,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 513,
        category: 2,
        size: 150,
        tags: ["NODEJS", "WEB","JavaScript"]),
    new CourseModel(
        ID: 9,
        name: "Architecting for Reliablility on AWS",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 215,
        category: 3,
        size: 150,
        tags: ["AWS","C++","C"]),
    new CourseModel(
        ID: 10,
        name: "Architecting for Security on AWS",
        level: 2,
        rating: 2.5,
        date: DateTime.now(),
        numberComment: 545,
        category: 4,
        size: 150,
        tags: ["AWS", "SECURITY"]),
    new CourseModel(
        ID: 11,
        name: "Python: The Big Picture",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 321,
        category: 3,
        size: 150,
        tags: ["PYTHON"]),
    new CourseModel(
        ID: 12,
        name: "Programming with R",
        level: 2,
        rating: 5,
        date: DateTime.now(),
        numberComment: 313,
        category: 4,
        size: 150,
        tags: ["R"]),
    new CourseModel(
        ID: 13,
        name: "Malware Analysis: Identifying and Defeating",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 211,
        category: 2,
        size: 150,
        tags: ["MALWARE", "JAVA"]),
    new CourseModel(
        ID: 14,
        name: "Creating Security Baseline in Microsoft",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 215,
        category: 3,
        size: 150,
        tags: ["SECURITY"]),
    new CourseModel(
        ID: 15,
        name: "Python for Data Analysts",
        level: 2,
        rating: 3.5,
        date: DateTime.now(),
        numberComment: 111,
        category: 2,
        size: 150,
        tags: ["PYTHON"]),
  ];
  void setBookmark(int id, bool b) {
    couserList.firstWhere((element) => element.ID == id).bookmark = b;
    notifyListeners();
  }

  List<CourseModel> findByTag(String tag) {
    return couserList
        .where((element) => element.tags.contains(tag.toUpperCase()))
        .toList();
  }

  List<CourseModel> getCoursesByCate(int category) {
    return couserList.where((course) => course.category == category).toList();
  }
}
