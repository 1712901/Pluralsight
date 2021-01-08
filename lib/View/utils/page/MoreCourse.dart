import 'dart:convert';

import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/TopCourses.Dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class MoreCourse extends StatefulWidget {
  final String title;
  final int type;
  const MoreCourse({Key key, this.title, this.type=-1}) : super(key: key);

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
        body: widget.type!=-1? Consumer<TopCourses>(builder: (context, provider, _) {
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
        }):Container());
  }

  Future<void> _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
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
          limit: 10, page: currentPage, type: widget.type);
      if (response.statusCode == 200) {
        ResGetTopCourse resGetTopCourse =
            ResGetTopCourse.fromJson(jsonDecode(response.body));
        if (resGetTopCourse.courses.length < 10) {
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
}
