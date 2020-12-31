import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class InstructorService {
  static const String _API_HOST = 'http://api.dev.letstudy.org';
  //static const String _API_HOST = 'https://api.letstudy.org';

  static String _urlGetInstructor = _API_HOST + "/instructor";
  static String _urlGetInstructorDetail = _API_HOST + "/instructor/detail";

  static Future<Response> getInstructor() async {
    return await http.get(_urlGetInstructor);
  }

  static Future<Response> getInstructorDetail({String intructorId}) async {
    return await http.get("$_urlGetInstructorDetail/$intructorId");
  }
}
