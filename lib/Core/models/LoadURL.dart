import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';
import 'package:Pluralsight/Core/models/DownLoad/ManagerData.dart';
import 'package:flutter/cupertino.dart';

class LoadURL extends ChangeNotifier {
  String url;
  bool loadLocal;
  double seek;
  LoadURL({this.url});
  Future<void> setUrl(String url,{String lessonID="intro",String courseId,String userId,double seek=0}) async {
    this.seek=seek;
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
    if(this.url==null)
      return false;
    if (url.contains("youtube.com")) return true;
    return false;
  }
  bool isMp4(){
    if(this.url==null)
      return false;
    String name=url.split(new RegExp(r"(\/|\?)")).firstWhere((element) => element.endsWith(".mp4"),orElse: ()=>null);
    if(name!=null)
      return true;
    return false;
  }
  Future<String> _getUrlLocalStore({String courseID,String userID,String lessonID}) async {
    ManagerData managerData=new ManagerData();
    await managerData.openDatabase();
    return await managerData.getPathStore(courseID: courseID,userID: userID,lessonID: lessonID);
  }
}
