import 'dart:convert';

SubmitAnswers submitExerciseFromJson(String str) => SubmitAnswers.fromJson(json.decode(str));

String submitExerciseToJson(SubmitAnswers data) => json.encode(data.toJson());

class SubmitAnswers {
  SubmitAnswers({
    this.exerciseId,
    this.questions,
  });

  String exerciseId;
  List<Question> questions;

  factory SubmitAnswers.fromJson(Map<String, dynamic> json) => SubmitAnswers(
    exerciseId: json["exerciseId"],
    questions: List<Question>.from(json["submits"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "exerciseId": exerciseId,
    "submits": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    this.id,
    this.answers,
  });

  String id;
  List<String> answers;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    answers: List<String>.from(json["answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "answers": List<dynamic>.from(answers.map((x) => x)),
  };
}
