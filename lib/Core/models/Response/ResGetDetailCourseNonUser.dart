import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/Response/ResInstructorDeatil.dart';

ResGetDetailCourseNonUser resGetDetailCourseNonUserFromJson(String str) =>
    ResGetDetailCourseNonUser.fromJson(json.decode(str));

String resGetDetailCourseNonUserToJson(ResGetDetailCourseNonUser data) =>
    json.encode(data.toJson());

class ResGetDetailCourseNonUser {
  ResGetDetailCourseNonUser({
    this.message,
    this.courseDetail,
  });

  String message;
  CourseDetailModel courseDetail;

  factory ResGetDetailCourseNonUser.fromJson(Map<String, dynamic> json) =>
      ResGetDetailCourseNonUser(
        message: json["message"],
        courseDetail: CourseDetailModel.fromJson(json["payload"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "payload": courseDetail.toJson(),
      };
}

class CourseDetailModel {
  CourseDetailModel({
    this.id,
    this.title,
    this.subtitle,
    this.price,
    this.description,
    this.requirement,
    this.learnWhat,
    this.soldNumber,
    this.ratedNumber,
    this.videoNumber,
    this.totalHours,
    this.formalityPoint,
    this.contentPoint,
    this.presentationPoint,
    this.imageUrl,
    this.promoVidUrl,
    this.status,
    this.isHidden,
    this.createdAt,
    this.updatedAt,
    this.instructorId,
    this.typeUploadVideoLesson,
    this.section,
    this.ratings,
    this.averagePoint,
    this.instructor,
    this.coursesLikeCategory,
  });

  String id;
  String title;
  String subtitle;
  int price;
  String description;
  List<String> requirement;
  List<String> learnWhat;
  int soldNumber;
  int ratedNumber;
  int videoNumber;
  double totalHours;
  double formalityPoint;
  double contentPoint;
  double presentationPoint;
  String imageUrl;
  String promoVidUrl;
  String status;
  bool isHidden;
  DateTime createdAt;
  DateTime updatedAt;
  String instructorId;
  int typeUploadVideoLesson;
  List<Section> section;
  Ratings ratings;
  String averagePoint;
  InstructorDetail instructor;
  List<CourseInfor> coursesLikeCategory;

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailModel(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        description: json["description"],
        requirement: json["requirement"] == null
            ? null
            : List<String>.from(json["requirement"].map((x) => x)),
        learnWhat: List<String>.from(json["learnWhat"].map((x) => x)),
        soldNumber: json["soldNumber"],
        ratedNumber: json["ratedNumber"],
        videoNumber: json["videoNumber"],
        totalHours: json["totalHours"].toDouble(),
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint: json["contentPoint"] == null
            ? null
            : json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        imageUrl: json["imageUrl"],
        promoVidUrl: json["promoVidUrl"],
        status: json["status"],
        isHidden: json["isHidden"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
        typeUploadVideoLesson: json["typeUploadVideoLesson"],
        section: json["section"] == null
            ? null
            : List<Section>.from(
                json["section"].map((x) => Section.fromJson(x))),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        averagePoint:
            json["averagePoint"] == null ? null : json["averagePoint"],
        instructor: json["instructor"] == null
            ? null
            : InstructorDetail.fromJson(json["instructor"]),
        coursesLikeCategory: json["coursesLikeCategory"] == null
            ? null
            : List<CourseInfor>.from(json["coursesLikeCategory"]
                .map((x) => CourseInfor.fromJsonGetDetailCourse(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "price": price,
        "description": description,
        "requirement": List<dynamic>.from(requirement.map((x) => x)),
        "learnWhat": List<dynamic>.from(learnWhat.map((x) => x)),
        "soldNumber": soldNumber,
        "ratedNumber": ratedNumber,
        "videoNumber": videoNumber,
        "totalHours": totalHours,
        "formalityPoint": formalityPoint,
        "contentPoint": contentPoint,
        "presentationPoint": presentationPoint,
        "imageUrl": imageUrl,
        "promoVidUrl": promoVidUrl,
        "status": status,
        "isHidden": isHidden,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "instructorId": instructorId,
        "typeUploadVideoLesson": typeUploadVideoLesson,
        "section": section == null
            ? null
            : List<dynamic>.from(section.map((x) => x.toJson())),
        "ratings": ratings == null ? null : ratings.toJson(),
        "averagePoint": averagePoint == null ? null : averagePoint,
        "instructor": instructor == null ? null : instructor.toJson(),
        "coursesLikeCategory": coursesLikeCategory == null
            ? null
            : List<dynamic>.from(coursesLikeCategory.map((x) => x.toJson())),
      };
  CourseInfor convertToCourseInfor() {
    return CourseInfor.fromJson(this.toJson());
  }
}

class Ratings {
  Ratings({
    this.ratingList,
    this.stars,
  });

  List<RatingList> ratingList;
  List<int> stars;

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        ratingList: List<RatingList>.from(
            json["ratingList"].map((x) => RatingList.fromJson(x))),
        stars: List<int>.from(json["stars"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ratingList": List<dynamic>.from(ratingList.map((x) => x.toJson())),
        "stars": List<dynamic>.from(stars.map((x) => x)),
      };
}

class RatingList {
  RatingList({
    this.id,
    this.userId,
    this.courseId,
    this.formalityPoint,
    this.contentPoint,
    this.presentationPoint,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.averagePoint,
  });

  String id;
  String userId;
  String courseId;
  double formalityPoint;
  double contentPoint;
  double presentationPoint;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  UserInfo user;
  double averagePoint;

  factory RatingList.fromJson(Map<String, dynamic> json) => RatingList(
        id: json["id"],
        userId: json["userId"],
        courseId: json["courseId"],
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint: json["contentPoint"] == null
            ? null
            : json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: UserInfo.fromJsonGetdetailCourse(json["user"]),
        averagePoint: json["averagePoint"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "courseId": courseId,
        "formalityPoint": formalityPoint,
        "contentPoint": contentPoint,
        "presentationPoint": presentationPoint,
        "content": content,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "averagePoint": averagePoint,
      };
}

class Section {
  Section({
    this.id,
    this.courseId,
    this.numberOrder,
    this.name,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.lesson,
    this.sumHours,
    this.sumLessonFinish,
  });

  String id;
  String courseId;
  int numberOrder;
  String name;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  List<Lesson> lesson;
  double sumHours;
  int sumLessonFinish;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        courseId: json["courseId"],
        numberOrder: json["numberOrder"],
        name: json["name"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        lesson:
            List<Lesson>.from(json["lesson"].map((x) => Lesson.fromJson(x))),
        sumHours: json["sumHours"].toDouble(),
        sumLessonFinish: json["sumLessonFinish"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "numberOrder": numberOrder,
        "name": name,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "lesson": List<dynamic>.from(lesson.map((x) => x.toJson())),
        "sumHours": sumHours,
        "sumLessonFinish": sumLessonFinish,
      };
}

class Lesson {
  Lesson({
    this.id,
    this.courseId,
    this.sectionId,
    this.numberOrder,
    this.name,
    this.content,
    this.videoName,
    this.videoUrl,
    this.captionName,
    this.hours,
    this.isPreview,
    this.isPublic,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String courseId;
  String sectionId;
  int numberOrder;
  String name;
  dynamic content;
  String videoName;
  dynamic videoUrl;
  dynamic captionName;
  double hours;
  bool isPreview;
  bool isPublic;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        courseId: json["courseId"],
        sectionId: json["sectionId"],
        numberOrder: json["numberOrder"],
        name: json["name"],
        content: json["content"],
        videoName: json["videoName"],
        videoUrl: json["videoUrl"],
        captionName: json["captionName"],
        hours: json["hours"].toDouble(),
        isPreview: json["isPreview"],
        isPublic: json["isPublic"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseId": courseId,
        "sectionId": sectionId,
        "numberOrder": numberOrder,
        "name": name,
        "content": content,
        "videoName": videoName,
        "videoUrl": videoUrl,
        "captionName": captionName,
        "hours": hours,
        "isPreview": isPreview,
        "isPublic": isPublic,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
