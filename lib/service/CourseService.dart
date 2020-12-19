import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CourseService {
  // email:kih87349@cuoly.com
  // password:123456789

  static const String API_HOST = 'http://api.dev.letstudy.org';
  //static const String API_HOST = 'https://api.letstudy.org';

  static const int TOP_NEW = 1;
  static const int TOP_SELL = 2;
  static const int TOP_RATE = 3;
  static String _urlTopSell = API_HOST + "/course/top-sell";
  static String _urlTopNew = API_HOST + "/course/top-new";
  static String _urlTopRate = API_HOST + "/course/top-rate";

  static Future<http.Response> getTopSell({int limit, int page}) async {
    try {
      return await http.post(_urlTopSell,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({"limit": limit, "page": page}));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> getTopNew({int limit, int page}) async {
    try {
      return await http.post(_urlTopNew,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({"limit": limit, "page": page}));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> getTopRate({int limit, int page}) async {
    try {
      return await http.post(_urlTopRate,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({"limit": limit, "page": page}));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> getTopCourse(
      {int limit, int page, int type}) async {
    if (type == TOP_NEW) return getTopNew(limit: limit, page: page);
    if (type == TOP_RATE) return getTopRate(limit: limit, page: page);
    if (type == TOP_SELL) return getTopSell(limit: limit, page: page);
    return null;
  }
}
