import 'dart:convert';

ResSubmitAnswers resSubmitAnswersFromJson(String str) => ResSubmitAnswers.fromJson(json.decode(str));

String resSubmitAnswersToJson(ResSubmitAnswers data) => json.encode(data.toJson());

class ResSubmitAnswers {
  ResSubmitAnswers({
    this.message,
    this.payload,
  });

  String message;
  Payload payload;

  factory ResSubmitAnswers.fromJson(Map<String, dynamic> json) => ResSubmitAnswers(
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
    this.result,
  });

  Result result;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.answerSheet,
    this.score,
    this.totalQuestion,
    this.listQuestionTrue,
  });

  Map<String, List<String>> answerSheet;
  int score;
  int totalQuestion;
  List<dynamic> listQuestionTrue;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    answerSheet: Map.from(json["answerSheet"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    score: json["score"],
    totalQuestion: json["totalQuestion"],
    listQuestionTrue: List<dynamic>.from(json["listQuestionTrue"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "answerSheet": Map.from(answerSheet).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "score": score,
    "totalQuestion": totalQuestion,
    "listQuestionTrue": List<dynamic>.from(listQuestionTrue.map((x) => x)),
  };
}
