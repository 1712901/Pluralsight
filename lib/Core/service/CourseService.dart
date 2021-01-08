import 'dart:convert';
import 'dart:io';

import 'package:Pluralsight/Core/models/SearchMode.dart';
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
  static String _urlSearch = API_HOST + "/course/search";
  static String _urlSearchV2 = API_HOST + "/course/searchV2";
  static String _urlHistory = API_HOST + "/course/search-history";
  static String _urlDeleteHistory = API_HOST + "/course/delete-search-history";
  static String _urlGetDetail = API_HOST + "/course/get-course-detail";
  static String _urlPostComment = API_HOST + "/course/rating-course";

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

  static Future<http.Response> search(
      {String keyword, Opt opt, int limit, int offset}) async {
    print(Search(keyword: keyword, opt: opt, limit: limit, offset: offset)
        .toJson());
    return await http.post(_urlSearch,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(
            Search(keyword: keyword, opt: opt, limit: limit, offset: offset)
                .toJson()));
  }

  static Future<http.Response> searchV2(
      {String token, String keyword, Opt opt, int limit, int offset}) async {
    return await http.post(_urlSearchV2,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode(SearchV2(
                token: token,
                keyword: keyword,
                opt: opt,
                limit: limit,
                offset: offset)
            .toJson()));
  }

  static Future<http.Response> getHistory({String token}) async {
    return await http
        .get(_urlHistory, headers: {'Authorization': 'Bearer ' + token});
  }

  static Future<http.Response> deleteHistory(
      {String token, String historyID}) async {
    return await http.delete("$_urlDeleteHistory/$historyID",
        headers: {'Authorization': 'Bearer ' + token});
  }

  static Future<http.Response> getDetail(
      {String courseID, String userID}) async {
    print("$_urlGetDetail/$courseID/$userID");
    return await http.get("$_urlGetDetail/$courseID/$userID");
  }
    static Future<http.Response> postCommnent(
      {String token,String courseID, String content, double formalityPoint,double contentPoint,double presentationPoint}) async {
    return await http.post(_urlPostComment,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode(
          {
            "courseId":courseID,
            "content":content,
            "presentationPoint":presentationPoint,
            "formalityPoint":formalityPoint,
            "contentPoint":contentPoint
          }
        ));
  }
}
