import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserService {
  // email:kih87349@cuoly.com
  // password:123456789
  //dev
  // email: xkr17684@zwoho.com
  // password:12345678

  static const String _API_HOST = 'http://api.dev.letstudy.org';
  //static const String _API_HOST = 'https://api.letstudy.org';

  static String _urlRegis = _API_HOST + "/user/register";
  static String _urlSendmail = _API_HOST + "/user/send-activate-email";
  static String _urlLogin = _API_HOST + "/user/login";
  static String _urlForgetPass = _API_HOST + "/user/forget-pass/send-email";
  static String _urlGetProfile = _API_HOST + "/user/me";
  static String _urlLikeCourse = _API_HOST + "/user/like-course";
  static String _urlGetFavoriteCourses =
      _API_HOST + "/user/get-favorite-courses";
  static String _urlRecommend = _API_HOST + "/user/recommend-course";

  static Future<http.Response> registerAccount(
      {String username, String email, String phone, String password}) async {
    try {
      return await http.post(_urlRegis,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            'name': username, //thay bằng username => api.dev
            'email': email,
            'phone': phone,
            'password': password
          }));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> sendMail(String email) async {
    try {
      return await http.post(_urlSendmail,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            'email': email,
          }));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> login({String email, String password}) async {
    try {
      return await http.post(_urlLogin,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> forgetPassword({String email}) async {
    try {
      return await http.post(_urlForgetPass,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode({
            'email': email,
          }));
    } on SocketException {
      return null;
    }
  }

  static Future<http.Response> getProfile({String token}) async {
    print("tokent:${token}");
    return await http.get(
      _urlGetProfile,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + token,
        //'Authorization': 'Bearer ' + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4OTNlN2IwLTUzMzItNDNiZC1hNjYwLTI3ZmNjNmRmNmQ5NyIsImlhdCI6MTYwNzc4NzQxMCwiZXhwIjoxNjA3Nzk0NjEwfQ.sucAd5yDN0rYzqP2U0cjPWfz9ob9OUHouUAgXSfy_U4",
      },
    );
  }

  static Future<http.Response> likeCourse(
      {String token, String courseId}) async {
    return await http.post(_urlLikeCourse,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode({
          'courseId': courseId,
        }));
  }

  static Future<http.Response> getFavoriteCourses({String token}) async {
    return await http.get(
      _urlGetFavoriteCourses,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
  }

  static Future<http.Response> getRecommendCourses(
      {String idUser, int limit, int offset}) async {
    return await http.get(
      "$_urlRecommend/$idUser/$limit/$offset",
    );
  }
}
