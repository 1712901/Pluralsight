import 'package:http/http.dart' as http;

class LessonService{
  static const String _API_HOST = 'http://api.dev.letstudy.org';
  //static const String _API_HOST = 'https://api.letstudy.org';

  static String _urlGetURLLesson = _API_HOST + "/lesson/video";

  static Future<http.Response> getURLLesson(
      {String token, String courseID,String lessonId}) async {
    return await http.get("$_urlGetURLLesson/$courseID/$lessonId",
        headers: {'Authorization': 'Bearer ' + token,});
  }
}