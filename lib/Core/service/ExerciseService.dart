import 'dart:convert';

import 'package:Pluralsight/Core/models/SubmitAnswers.dart';
import 'package:http/http.dart';

class ExerciseService{
  static const String _API_HOST = 'http://api.dev.letstudy.org';
  //static const String _API_HOST = 'https://api.letstudy.org';
  static String _urlListExerciseLesson=_API_HOST + "/exercise/student/list-exercise-lesson";
  static String _urlGetQuestion=_API_HOST + "/exercise/student/exercise-test";
  static String _urlSubmit=_API_HOST + "/exercise/student/submit-exercise";

  static Future<Response> getListExerciseLesson(
      {String token, String lessonId}) async {
    return await post(_urlListExerciseLesson,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode({
          'lessonId': lessonId,
        }));
  }
  static Future<Response> getQuestion(
      {String token, String exerciseId}) async {
    return await post(_urlGetQuestion,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode({
          'exerciseId': exerciseId,
        }));
  }
  static Future<Response> submitAnswers(
      {String token, SubmitAnswers submitExercise}) async {
    print(jsonEncode(submitExercise));
    return await post(_urlSubmit,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode(submitExercise));
  }
}