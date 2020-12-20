import 'package:Pluralsight/models/SearchMode.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String API_HOST = 'http://api.dev.letstudy.org';
  //static const String API_HOST = 'https://api.letstudy.org';

  static String _urlGetAll = API_HOST + "/category/all";

  static Future<http.Response> getAll() async {
    return await http.get(
      _urlGetAll,
      headers: {'Content-type': 'application/json'},
    );
  }

  static Future<http.Response> getCourseByCategory({String courseId})  {
    return  CourseService.search(
        keyword: "",
        limit: null,
        offset: null,
        opt: Opt(
            sort: Sort(attribute: "price", rule: "ASC"), category: [courseId]));
  }
}
