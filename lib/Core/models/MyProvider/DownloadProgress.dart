import 'package:flutter/cupertino.dart';

class DownLoadProgress extends ChangeNotifier{
  String courseID;
  String userID;
  String lessonId;
  bool isLoad=false;
  double percent=0;
  DownLoadProgress({this.userID,this.courseID,this.lessonId,this.isLoad=false,this.percent=0});
  void inProgress({double percent=0}){
    this.percent=percent;
    notifyListeners();
  }
  void startDownload({String userID,String courseID,String lessonId}){
    this.isLoad=true;
    this.lessonId=lessonId;
    this.courseID=courseID;
    this.userID=userID;
  }
  void complete(){
    this.isLoad=false;
    percent=0;
    notifyListeners();
  }
  bool isDownloading(){
    return isLoad;
  }
}