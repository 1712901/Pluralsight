import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';
import 'package:Pluralsight/Core/models/DownLoad/ManagerData.dart';
import 'package:flutter/cupertino.dart';

class LoadURL extends ChangeNotifier {
  String url;
  bool loadLocal;
  LoadURL({this.url});
  Future<void> setUrl(String url,{String lessonID="intro",String courseId,String userId}) async {
    String pathLocal;
    if (userId == null) {
      loadLocal = false;
    } else {
      pathLocal = await _getUrlLocalStore(
          courseID: courseId, userID: userId, lessonID: lessonID);
    }
    print("$courseId-$lessonID");
    print("Local: $pathLocal");
    if (pathLocal != null) {
      this.url = pathLocal;
      this.loadLocal = true;
    } else {
      this.url = url;
      this.loadLocal = false;
    }
    notifyListeners();
  }

  bool isYotuber() {
    if (url.contains("youtube.com")) return true;
    return false;
  }
  Future<String> _getUrlLocalStore({String courseID,String userID,String lessonID}) async {
    ManagerData managerData=new ManagerData();
    await managerData.openDatabase();
    return await managerData.getPathStore(courseID: courseID,userID: userID,lessonID: lessonID);
  }
}
