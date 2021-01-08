import 'dart:convert';

ResMyCourses resMyCoursesFromJson(String str) => ResMyCourses.fromJson(json.decode(str));

String resMyCoursesToJson(ResMyCourses data) => json.encode(data.toJson());

class ResMyCourses {
    ResMyCourses({
        this.message,
        this.paymentCourses,
    });

    String message;
    List<MyPaymentCourse> paymentCourses;

    factory ResMyCourses.fromJson(Map<String, dynamic> json) => ResMyCourses(
        message: json["message"],
        paymentCourses: List<MyPaymentCourse>.from(json["payload"].map((x) => MyPaymentCourse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": List<dynamic>.from(paymentCourses.map((x) => x.toJson())),
    };
}

class MyPaymentCourse {
    MyPaymentCourse({
        this.paymentMethod,
        this.createdAt,
        this.payloadCourseId,
        this.payloadCourseTitle,
        this.payloadCoursePrice,
        this.instructorId,
        this.instructorName,
        this.courseId,
        this.courseTitle,
        this.coursePrice,
        this.courseInstructorId,
        this.courseInstructorUserId,
        this.courseInstructorUserName,
    });

    String paymentMethod;
    DateTime createdAt;
    String payloadCourseId;
    String payloadCourseTitle;
    int payloadCoursePrice;
    String instructorId;
    String instructorName;
    String courseId;
    String courseTitle;
    int coursePrice;
    String courseInstructorId;
    String courseInstructorUserId;
    String courseInstructorUserName;

    factory MyPaymentCourse.fromJson(Map<String, dynamic> json) => MyPaymentCourse(
        paymentMethod: json["paymentMethod"],
        createdAt: DateTime.parse(json["createdAt"]),
        payloadCourseId: json["courseId"],
        payloadCourseTitle: json["courseTitle"],
        payloadCoursePrice: json["coursePrice"],
        instructorId: json["instructorId"],
        instructorName: json["instructorName"],
        courseId: json["course.id"],
        courseTitle: json["course.title"],
        coursePrice: json["course.price"],
        courseInstructorId: json["course.instructor.id"],
        courseInstructorUserId: json["course.instructor.user.id"],
        courseInstructorUserName: json["course.instructor.user.name"],
    );

    Map<String, dynamic> toJson() => {
        "paymentMethod": paymentMethod,
        "createdAt": createdAt.toIso8601String(),
        "courseId": payloadCourseId,
        "courseTitle": payloadCourseTitle,
        "coursePrice": payloadCoursePrice,
        "instructorId": instructorId,
        "instructorName": instructorName,
        "course.id": courseId,
        "course.title": courseTitle,
        "course.price": coursePrice,
        "course.instructor.id": courseInstructorId,
        "course.instructor.user.id": courseInstructorUserId,
        "course.instructor.user.name": courseInstructorUserName,
    };
}
