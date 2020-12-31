import 'package:Pluralsight/Core/models/Course.dart';
import 'package:flutter/cupertino.dart';

class DownloadModel extends ChangeNotifier {
  List<CourseModel> courses = [];
  int size = 0;

  void downloadCourse(CourseModel c) {
    if (!courses.contains(c)) {
      courses.add(c);
      size += c.size;
    }
    ;
    notifyListeners();
  }

  void removeCourse(CourseModel c) {
    if (containsCourse(c.ID)) {
      courses.remove(c);
      size -= c.size;
    }
    notifyListeners();
  }

  void removeAll() {
    courses.clear();
    size = 0;
    notifyListeners();
  }

  bool containsCourse(int idCourse) {
    bool result = false;
    courses.forEach((element) {
      if (element.ID == idCourse) {
        result = true;
        return;
      }
    });
    return result;
  }
}
