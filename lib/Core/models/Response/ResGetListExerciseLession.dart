import 'dart:convert';

ResGetListExercise resGetListExerciseFromJson(String str) => ResGetListExercise.fromJson(json.decode(str));

String resGetListExerciseToJson(ResGetListExercise data) => json.encode(data.toJson());

class ResGetListExercise {
  ResGetListExercise({
    this.message,
    this.data,
  });

  String message;
  ListExerciseData data;

  factory ResGetListExercise.fromJson(Map<String, dynamic> json) => ResGetListExercise(
    message: json["message"],
    data: ListExerciseData.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "payload": data.toJson(),
  };
}

class ListExerciseData {
  ListExerciseData({
    this.exercises,
  });

  List<Exercise> exercises;

  factory ListExerciseData.fromJson(Map<String, dynamic> json) => ListExerciseData(
    exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };
}

class Exercise {
  Exercise({
    this.id,
    this.numberQuestion,
    this.title,
    this.exercisesQuestions,
    this.usersDoExercises,
  });

  String id;
  int numberQuestion;
  String title;
  List<ExercisesQuestion> exercisesQuestions;
  List<UsersDoExercise> usersDoExercises;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    numberQuestion: json["numberQuestion"],
    title: json["title"],
    exercisesQuestions: List<ExercisesQuestion>.from(json["exercises_questions"].map((x) => ExercisesQuestion.fromJson(x))),
    usersDoExercises: List<UsersDoExercise>.from(json["users_do_exercises"].map((x) => UsersDoExercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numberQuestion": numberQuestion,
    "title": title,
    "exercises_questions": List<dynamic>.from(exercisesQuestions.map((x) => x.toJson())),
    "users_do_exercises": List<dynamic>.from(usersDoExercises.map((x) => x.toJson())),
  };
}

class ExercisesQuestion {
  ExercisesQuestion({
    this.id,
  });

  String id;

  factory ExercisesQuestion.fromJson(Map<String, dynamic> json) => ExercisesQuestion(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class UsersDoExercise {
  UsersDoExercise({
    this.score,
  });

  int score;

  factory UsersDoExercise.fromJson(Map<String, dynamic> json) => UsersDoExercise(
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "score": score,
  };
}
