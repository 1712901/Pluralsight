import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UserService {
  // email:kih87349@cuoly.com
  // password:123456789

  //static const String API_HOST = 'https://api.dev.letstudy.org';
  static const String API_HOST = 'https://api.letstudy.org';

  static String _urlRegis = API_HOST + "/user/register";
  static String _urlSendmail = API_HOST + "/user/send-activate-email";
  static String _urlLogin = API_HOST + "/user/login";
  static String _urlForgetPass = API_HOST + "/user/forget-pass/send-email";
  static String _urlGetProfile = API_HOST + "/user/me";

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
}
