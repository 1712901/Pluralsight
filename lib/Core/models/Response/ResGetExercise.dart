import 'dart:convert';

ResGetExercise resGetExerciseFromJson(String str) => ResGetExercise.fromJson(json.decode(str));

String resGetExerciseToJson(ResGetExercise data) => json.encode(data.toJson());

class ResGetExercise {
  ResGetExercise({
    this.message,
    this.payload,
  });

  String message;
  Payload payload;

  factory ResGetExercise.fromJson(Map<String, dynamic> json) => ResGetExercise(
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
    this.exercises,
  });

  Exercises exercises;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    exercises: Exercises.fromJson(json["exercises"]),
  );

  Map<String, dynamic> toJson() => {
    "exercises": exercises.toJson(),
  };
}

class Exercises {
  Exercises({
    this.courseId,
    this.id,
    this.lessonId,
    this.time,
    this.title,
    this.exercisesQuestions,
  });

  String courseId;
  String id;
  String lessonId;
  int time;
  String title;
  List<ExercisesQuestion> exercisesQuestions;

  factory Exercises.fromJson(Map<String, dynamic> json) => Exercises(
    courseId: json["courseId"],
    id: json["id"],
    lessonId: json["lessonId"],
    time: json["time"],
    title: json["title"],
    exercisesQuestions: List<ExercisesQuestion>.from(json["exercises_questions"].map((x) => ExercisesQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "id": id,
    "lessonId": lessonId,
    "time": time,
    "title": title,
    "exercises_questions": List<dynamic>.from(exercisesQuestions.map((x) => x.toJson())),
  };
}

class ExercisesQuestion {
  ExercisesQuestion({
    this.content,
    this.contentHtml,
    this.id,
    this.isMultipleChoice,
    this.exercisesAnswers,
  });

  String content;
  String contentHtml;
  String id;
  bool isMultipleChoice;
  List<ExercisesAnswer> exercisesAnswers;

  factory ExercisesQuestion.fromJson(Map<String, dynamic> json) => ExercisesQuestion(
    content: json["content"],
    contentHtml: json["contentHtml"],
    id: json["id"],
    isMultipleChoice: json["isMultipleChoice"],
    exercisesAnswers: List<ExercisesAnswer>.from(json["exercises_answers"].map((x) => ExercisesAnswer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "contentHtml": contentHtml,
    "id": id,
    "isMultipleChoice": isMultipleChoice,
    "exercises_answers": List<dynamic>.from(exercisesAnswers.map((x) => x.toJson())),
  };
}

class ExercisesAnswer {
  ExercisesAnswer({
    this.content,
    this.id,
  });

  String content;
  String id;

  factory ExercisesAnswer.fromJson(Map<String, dynamic> json) => ExercisesAnswer(
    content: json["content"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "id": id,
  };
}
