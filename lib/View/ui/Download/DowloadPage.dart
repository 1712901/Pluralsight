import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';
import 'package:Pluralsight/Core/models/DownLoad/ManagerData.dart';
import 'package:Pluralsight/Core/models/DownloadModel.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/View/utils/Widget/AppBar.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownLoadsPage extends StatefulWidget {
  @override
  _DownLoadsPageState createState() => _DownLoadsPageState();
}

class _DownLoadsPageState extends State<DownLoadsPage> {
  List<CourseInfor> coursesInfor=null;
  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: myAppbar(title: S.current.Download,context: context),
      body: coursesInfor!=null?Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                        onPressed: () {
                          Provider.of<DownloadModel>(context,listen: false).removeAll();
                        },
                        child: Text(
                          S.current.REMOVE_ALL,
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              ),
              Flexible(
                  child: ListView.builder(
                      itemCount: coursesInfor.length,
                      itemBuilder: (context, index) {
                        return CourseListTitle(
                          course: coursesInfor[index],
                          isLoaded: true,
                        );
                      })),
            ],
          )
      ):Center(child: CircularProgressIndicator(),),
    );
  }
  Future<void> loadData() async {
     AccountInf accountInf =Provider.of<AccountInf>(context,listen: false);
     ManagerData managerData=new ManagerData();
     await managerData.openDatabase();
     List<CourseEntity> courses=await managerData.getAllCourses(userID: accountInf.userInfo.id);
     coursesInfor=[];
     for(int i=0;i<courses.length;i++){
       var res= await CourseService.getCourseInfo(token: accountInf.token,courseID: courses[i].courseID);
       if(res.statusCode==200){
         CourseInfor courseInfor=CourseInfor.fromJson(jsonDecode(res.body)['payload']);
         coursesInfor.add(courseInfor);
         List<LessonEntity> list=await managerData.getAllLesson(courseEntityID: courses[i].id);
         list.forEach((element) {
           print("${element.lessonID}-${element.path}");
         });
       }
     }
     setState(() {
     });
  }
}
