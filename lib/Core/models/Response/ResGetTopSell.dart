import 'dart:convert';

ResGetTopCourse resResGetTopCourseFromJson(String str) => ResGetTopCourse.fromJson(json.decode(str));

String resResGetTopCourseToJson(ResGetTopCourse data) => json.encode(data.toJson());

class ResGetTopCourse {
    ResGetTopCourse({
        this.message,
        this.courses,
    });

    String message;
    List<CourseInfor> courses;

    factory ResGetTopCourse.fromJson(Map<String, dynamic> json) => ResGetTopCourse(
        message: json["message"],
        courses: List<CourseInfor>.from(json["payload"].map((x) => CourseInfor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": List<dynamic>.from(courses.map((x) => x.toJson())),
    };
}

class CourseInfor {
    CourseInfor({
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
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.instructorId,
        this.typeUploadVideoLesson,
        this.instructorUserId,
        this.instructorUserName,
        this.averagePoint
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
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;
    String instructorId;
    int typeUploadVideoLesson;
    String instructorUserId;
    String instructorUserName;
    double averagePoint;

    factory CourseInfor.fromJson(Map<String, dynamic> json) => CourseInfor(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        description: json["description"],
        requirement: json["requirement"] == null ? null : List<String>.from(json["requirement"].map((x) => x)),
        learnWhat: json["learnWhat"] == null ? null : List<String>.from(json["learnWhat"].map((x) => x)),
        soldNumber: json["soldNumber"],
        ratedNumber: json["ratedNumber"],
        videoNumber: json["videoNumber"],
        totalHours: json["totalHours"].toDouble(),
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint:json["contentPoint"]==null?null: json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        imageUrl: json["imageUrl"],
        promoVidUrl: json["promoVidUrl"] == null ? null : json["promoVidUrl"],
        status: json["status"],
        isHidden: json["isHidden"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null :DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null :DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
        typeUploadVideoLesson: json["typeUploadVideoLesson"],
        instructorUserId: json["instructor.user.id"],
        instructorUserName: json["instructor.user.name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "price": price,
        "description": description,
        "requirement": requirement == null ? null : List<dynamic>.from(requirement.map((x) => x)),
        "learnWhat": List<dynamic>.from(learnWhat.map((x) => x)),
        "soldNumber": soldNumber,
        "ratedNumber": ratedNumber,
        "videoNumber": videoNumber,
        "totalHours": totalHours,
        "formalityPoint": formalityPoint,
        "contentPoint": contentPoint,
        "presentationPoint": presentationPoint,
        "imageUrl": imageUrl,
        "promoVidUrl": promoVidUrl == null ? null : promoVidUrl,
        "status": status,
        "isHidden": isHidden,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "instructorId": instructorId,
        "typeUploadVideoLesson": typeUploadVideoLesson,
        "instructor.user.id": instructorUserId,
        "instructor.user.name": instructorUserName,
    };
  factory CourseInfor.fromSearchJson(Map<String, dynamic> json) => CourseInfor(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        description: json["description"],
        requirement: json["requirement"] == null ? null : List<String>.from(json["requirement"].map((x) => x)),
        learnWhat: json["learnWhat"] == null ? null : List<String>.from(json["learnWhat"].map((x) => x)),
        soldNumber: json["soldNumber"],
        ratedNumber: json["ratedNumber"],
        videoNumber: json["videoNumber"],
        totalHours: json["totalHours"].toDouble(),
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint: json["contentPoint"]==null?null:json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        imageUrl: json["imageUrl"],
        promoVidUrl: json["promoVidUrl"] == null ? null : json["promoVidUrl"],
        status: json["status"],
        isHidden: json["isHidden"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null :DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null :DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
        typeUploadVideoLesson: json["typeUploadVideoLesson"],
        instructorUserId: json["instructor.user.id"],
        instructorUserName: json["name"],
    );
    factory CourseInfor.fromSearchV2Json(Map<String, dynamic> json) => CourseInfor(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        description: json["description"],
        requirement: json["requirement"] == null ? null : List<String>.from(json["requirement"].map((x) => x)),
        learnWhat: json["learnWhat"] == null ? null : List<String>.from(json["learnWhat"].map((x) => x)),
        soldNumber: json["soldNumber"],
        ratedNumber: json["ratedNumber"],
        videoNumber: json["videoNumber"],
        totalHours: json["totalHours"].toDouble(),
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint: json["contentPoint"]==null?null:json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        imageUrl: json["imageUrl"],
        promoVidUrl: json["promoVidUrl"] == null ? null : json["promoVidUrl"],
        status: json["status"],
        isHidden: json["isHidden"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null :DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null :DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
        typeUploadVideoLesson: json["typeUploadVideoLesson"],
        instructorUserId: json["instructor.user.id"],
        instructorUserName: json["name"],
    );
    factory CourseInfor.fromJsonGetDetailCourse(Map<String, dynamic> json) => CourseInfor(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        description: json["description"],
        requirement: json["requirement"] == null ? null : List<String>.from(json["requirement"].map((x) => x)),
        learnWhat: List<String>.from(json["learnWhat"].map((x) => x)),
        soldNumber: json["soldNumber"],
        ratedNumber: json["ratedNumber"],
        videoNumber: json["videoNumber"],
        totalHours: json["totalHours"].toDouble(),
        formalityPoint: json["formalityPoint"].toDouble(),
        contentPoint:json["contentPoint"]==null?null: json["contentPoint"].toDouble(),
        presentationPoint: json["presentationPoint"].toDouble(),
        imageUrl: json["imageUrl"],
        promoVidUrl: json["promoVidUrl"] == null ? null : json["promoVidUrl"],
        status: json["status"],
        isHidden: json["isHidden"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
        typeUploadVideoLesson: json["typeUploadVideoLesson"],
        instructorUserName: json["instructorName"],
        averagePoint:json["averagePoint"]==null?null: json["averagePoint"].toDouble(),
    );
}
