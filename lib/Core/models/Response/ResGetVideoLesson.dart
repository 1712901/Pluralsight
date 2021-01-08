import 'dart:convert';

ResGetVideoLesson resGetVideoLessonFromJson(String str) => ResGetVideoLesson.fromJson(json.decode(str));

String resGetVideoLessonToJson(ResGetVideoLesson data) => json.encode(data.toJson());

class ResGetVideoLesson {
    ResGetVideoLesson({
        this.message,
        this.videoLesson,
    });

    String message;
    VideoLesson videoLesson;

    factory ResGetVideoLesson.fromJson(Map<String, dynamic> json) => ResGetVideoLesson(
        message: json["message"],
        videoLesson: VideoLesson.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "payload": videoLesson.toJson(),
    };
}

class VideoLesson {
    VideoLesson({
        this.videoUrl,
        this.currentTime,
        this.isFinish,
    });

    String videoUrl;
    double currentTime;
    bool isFinish;

    factory VideoLesson.fromJson(Map<String, dynamic> json) => VideoLesson(
        videoUrl: json["videoUrl"],
        currentTime: json["currentTime"]==null?null:json["currentTime"].toDouble(),
        isFinish: json["isFinish"],
    );

    Map<String, dynamic> toJson() => {
        "videoUrl": videoUrl,
        "currentTime": currentTime,
        "isFinish": isFinish,
    };
}
