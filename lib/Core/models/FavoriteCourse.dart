import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';

class FavoriteCourse {
  FavoriteCourse({
    this.id,
    this.courseTitle,
    this.coursePrice,
    this.courseImage,
    this.instructorId,
    this.instructorName,
    this.courseSoldNumber,
    this.courseContentPoint,
    this.courseFormalityPoint,
    this.coursePresentationPoint,
    this.courseAveragePoint,
  });

  String id;
  String courseTitle;
  int coursePrice;
  String courseImage;
  String instructorId;
  String instructorName;
  int courseSoldNumber;
  double courseContentPoint;
  double courseFormalityPoint;
  double coursePresentationPoint;
  double courseAveragePoint;

  factory FavoriteCourse.fromJson(Map<String, dynamic> json) => FavoriteCourse(
        id: json["id"],
        courseTitle: json["courseTitle"],
        coursePrice: json["coursePrice"],
        courseImage: json["courseImage"],
        instructorId: json["instructorId"],
        instructorName: json["instructorName"],
        courseSoldNumber: json["courseSoldNumber"],
        courseContentPoint: json["courseContentPoint"] == null
            ? null
            : json["courseContentPoint"].toDouble(),
        courseFormalityPoint: json["courseFormalityPoint"].toDouble(),
        coursePresentationPoint: json["coursePresentationPoint"].toDouble(),
        courseAveragePoint: json["courseAveragePoint"] == null
            ? null
            : json["courseAveragePoint"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseTitle": courseTitle,
        "coursePrice": coursePrice,
        "courseImage": courseImage,
        "instructorId": instructorId,
        "instructorName": instructorName,
        "courseSoldNumber": courseSoldNumber,
        "courseContentPoint": courseContentPoint,
        "courseFormalityPoint": courseFormalityPoint,
        "coursePresentationPoint": coursePresentationPoint,
        "courseAveragePoint": courseAveragePoint,
      };
  CourseInfor convertToCourseInfor() {
    return CourseInfor(
        id: this.id,
        title: this.courseTitle,
        imageUrl: this.courseImage,
        instructorUserName: this.instructorName,
        price: this.coursePrice,
        );
  }
}
