import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MoreCourse extends StatelessWidget {
  final String title;
  final List<CourseModel> courses;
  const MoreCourse({Key key, this.title, this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CourseListModel courseList =
    //     Provider.of<CourseListModel>(context, listen: false);
    // List<CourseModel> _list = courseList.couserList
    //     .where((element) => element.category == type)
    //     .toList();
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return CourseListTitle(course: courses[index],indexChannel: -1,);
            },
            itemCount: courses.length,
          ),
        ));
  }
}
