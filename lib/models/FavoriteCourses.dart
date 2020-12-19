import 'package:Pluralsight/models/FavoriteCourse.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:flutter/cupertino.dart';

class FavoriteCourses extends ChangeNotifier {
  List<FavoriteCourse> favoriteCourses;


  void setFavoriteCourses({List<FavoriteCourse> favoriteCourses}) {
    this.favoriteCourses = favoriteCourses;
    notifyListeners();
  }

  bool isFavorite({String courseId}) {
    if (favoriteCourses == null) return false;
    return favoriteCourses.indexWhere((e) => e.id == courseId) >= 0;
  }

  void likeCourse({CourseInfor courseInfor}) {
    if (favoriteCourses == null) return;
    FavoriteCourse favoriteCourse = favoriteCourses
        .firstWhere((e) => e.id == courseInfor.id, orElse: () => null);
    if (favoriteCourse == null) {
      favoriteCourses.add(new FavoriteCourse(
          id: courseInfor.id,
          courseTitle: courseInfor.title,
          courseImage: courseInfor.imageUrl));
    } else {
      favoriteCourses.remove(favoriteCourse);
    }
    notifyListeners();
  }
}
