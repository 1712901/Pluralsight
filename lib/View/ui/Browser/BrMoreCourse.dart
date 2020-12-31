import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/TopCourses.Dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class BrMoreCourse extends StatefulWidget {
  final String title;
  final int type;

  const BrMoreCourse({Key key, this.title, this.type = -1}) : super(key: key);

  @override
  _BrMoreCourseState createState() => _BrMoreCourseState();
}

class _BrMoreCourseState extends State<BrMoreCourse> {
  ScrollController controller;
  int currentPage = 1;
  bool isCompleted = false;
  List<CourseInfor> recommedCourse = [];
  int limit = 10;
  int offsetCurrent = 0;

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
      body: SafeArea(
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.grey[800],
              title: Text(widget.title),
              expandedHeight: 200,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('assets/images/background.jpg',
                      fit: BoxFit.cover)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: widget.type != -1
                  ? Consumer<TopCourses>(
                      builder: (context, provider, _) {
                        List<CourseInfor> list =
                            provider.getTopCourse(type: widget.type);
                        return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => CourseListTitle(
                                      course: list[index],
                                    ),
                                childCount: list.length));
                      },
                    )
                  : Consumer<AccountInf>(
                      builder: (context, provider, _) {
                        List<CourseInfor> list = provider.getRecommendCourse();
                        return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => CourseListTitle(
                                      course: list[index],
                                    ),
                                childCount: list.length));
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    if (!isCompleted) {
      if (widget.type == CourseService.TOP_NEW) {
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
      } else {
        // String idUser =
        //     Provider.of<AccountInf>(context, listen: false).userInfo.id;
        int offset = Provider.of<AccountInf>(context, listen: false).offset;
        if (offsetCurrent < offset) {
          offsetCurrent = offset;
          return;
        }
        Response response = await UserService.getRecommendCourses(
            idUser: Provider.of<AccountInf>(context,listen: false).userInfo.id,
            limit: 10,
            offset: offsetCurrent);
        print(offsetCurrent);
        if (response.statusCode == 200) {
          ResGetTopCourse recommendCourse =
              ResGetTopCourse.fromJson(jsonDecode(response.body));
          if (recommendCourse.courses.length < 10) isCompleted = true;
          Provider.of<AccountInf>(context, listen: false).setCommendCourse(
              course: recommendCourse.courses, offset: offsetCurrent+limit);
          offsetCurrent += limit;
        }
      }
    }
  }
}