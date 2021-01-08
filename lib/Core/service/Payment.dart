import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaymentService {
  static const String _API_HOST = 'http://api.dev.letstudy.org';
  //static const String _API_HOST = 'https://api.letstudy.org';

  static String _urlPaymentFree = _API_HOST + "/payment/get-free-courses";  
  static String _urlMyCourses = _API_HOST + "/payment";  

  static Future<Response> paymentFreeCourse(
      {String token, String courseId}) async {
    return await http.post(_urlPaymentFree,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode({
          'courseId': courseId,
        }));
  }
  static Future<Response> getMyCourses(
      {String token, String courseId}) async {
    return await http.get(_urlMyCourses,
        headers: {
          'Authorization': 'Bearer ' + token,
        });
  }
}
