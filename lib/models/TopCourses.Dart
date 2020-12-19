import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:flutter/cupertino.dart';

class TopCourses extends ChangeNotifier {
  List<CourseInfor> topNew = [];
  List<CourseInfor> topSell = [];
  List<CourseInfor> topRating = [];
  int loadedPageTopNew = 0;
  int loadedPageSell = 0;
  int loadedPageRating = 0;

  List<CourseInfor> getTopCourse({int type}) {
    switch (type) {
      case CourseService.TOP_NEW:
        return topNew;
      case CourseService.TOP_RATE:
        return topRating;
      case CourseService.TOP_SELL:
        return topSell;
    }
  }

  void addTopCourses({List<CourseInfor> list, int type, int pageCurrent}) {
    switch (type) {
      case CourseService.TOP_NEW:
        this.topNew.addAll(list);
        this.loadedPageTopNew = pageCurrent;
        break;
      case CourseService.TOP_RATE:
        this.topRating.addAll(list);
        this.loadedPageRating = pageCurrent;
        break;
      case CourseService.TOP_SELL:
        this.topSell.addAll(list);
        this.loadedPageSell = pageCurrent;
        break;
    }
    notifyListeners();
  }

  int getPageCurre({int type}) {
    switch (type) {
      case CourseService.TOP_NEW:
        return this.loadedPageTopNew;
        break;
      case CourseService.TOP_RATE:
        return this.loadedPageRating;
        break;
      case CourseService.TOP_SELL:
        return this.loadedPageSell;
        break;
    }
    return null;
  }
}
