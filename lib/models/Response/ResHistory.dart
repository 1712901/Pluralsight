import 'dart:convert';

ResHistory resHistoryFromJson(String str) => ResHistory.fromJson(json.decode(str));

String resHistoryToJson(ResHistory data) => json.encode(data.toJson());

class ResHistory {
    ResHistory({
        this.message,
        this.payload,
    });

    String message;
    Payload payload;

    factory ResHistory.fromJson(Map<String, dynamic> json) => ResHistory(
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
        this.data,
    });

    List<History> data;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        data: List<History>.from(json["data"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class History {
    History({
        this.id,
        this.content,
    });

    String id;
    String content;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
    };
}
