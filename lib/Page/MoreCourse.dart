import 'dart:convert';

import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/TopCourses.Dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MoreCourse extends StatefulWidget {
  final String title;
  final int type;
  const MoreCourse({Key key, this.title, this.type}) : super(key: key);

  @override
  _MoreCourseState createState() => _MoreCourseState();
}

class _MoreCourseState extends State<MoreCourse> {
  ScrollController controller;
  int currentPage = 1;
  bool isCompleted = false;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    //getMorePage();
    loadMoreData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(_scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // body: FutureBuilder(
        //     future: CourseService.getTopCourse(
        //         limit: 8, page: currentPage++, type: widget.type),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         isloading = false;
        //         print("end");
        //         Response response = snapshot.data;
        //         if (response.statusCode == 200) {
        //           ResGetTopCourse resGetTopCourse =
        //               ResGetTopCourse.fromJson(jsonDecode(response.body));
        //           list.addAll(resGetTopCourse.courses);
        //           print(response.body);
        //           print(
        //               "${currentPage - 1} ${list.length} ${resGetTopCourse.courses.length}");
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 10),
        //             child: ListView.builder(
        //               controller: controller,
        //               itemBuilder: (context, index) {
        //                 return CourseListTitle(
        //                   course: list[index],
        //                   indexChannel: -1,
        //                 );
        //               },
        //               itemCount: list.length,
        //             ),
        //           );
        //         } else {
        //           return Center(
        //             child: Text("Loading"),
        //           );
        //         }
        //       } else {
        //         return Center(
        //           child: Text("Loading"),
        //         );
        //       }
        //     })
        body: Consumer<TopCourses>(builder: (context, provider, _) {
          List<CourseInfor> list = provider.getTopCourse(type: widget.type);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: list.length > 0
                ? ListView.builder(
                    controller: controller,
                    itemBuilder: (context, index) {
                      return CourseListTitle(
                        course: list[index],
                      );
                    },
                    itemCount: list.length,
                  )
                : Center(child: new CircularProgressIndicator()),
          );
        }));
  }

  Future<void> _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      // //getMorePage();
      // Response response = await CourseService.getTopCourse(
      //     limit: 10, page: currentPage++, type: widget.type);
      // if (response.statusCode == 200) {
      //   ResGetTopCourse resGetTopCourse =
      //       ResGetTopCourse.fromJson(jsonDecode(response.body));
      //   Provider.of<TopCourses>(context, listen: false)
      //       .addTopCourses(list: resGetTopCourse.courses, type: widget.type);
      // }
      loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    if (!isCompleted) {
      int loadedPage = Provider.of<TopCourses>(context, listen: false)
          .getPageCurre(type: widget.type);
      if (currentPage <= loadedPage) {
        currentPage = loadedPage + 1;
        return;
      }
      Response response = await CourseService.getTopCourse(
          limit: 8, page: currentPage, type: widget.type);
      if (response.statusCode == 200) {
        ResGetTopCourse resGetTopCourse =
            ResGetTopCourse.fromJson(jsonDecode(response.body));
        if (resGetTopCourse.courses.length < 8) {
          isCompleted = true;
        }
        Provider.of<TopCourses>(context, listen: false).addTopCourses(
            list: resGetTopCourse.courses,
            type: widget.type,
            pageCurrent: currentPage);
        print(currentPage);
        currentPage++;
      }
    }
  }

  // Future<void> getMorePage() async {
  //   if (!isloading) {
  //     setState(() {
  //       isloading = true;
  //     });
  //     Response response = await CourseService.getTopCourse(
  //         limit: 10, page: currentPage, type: widget.type);
  //     if (response.statusCode == 200) {
  //       ResGetTopCourse resGetTopCourse =
  //           ResGetTopCourse.fromJson(jsonDecode(response.body));
  //       setState(() {
  //         if (resGetTopCourse.courses.length == 10) isloading = false;
  //         list.addAll(resGetTopCourse.courses);
  //         currentPage++;
  //       });
  //     } else {}
  //   }
  // }
}
