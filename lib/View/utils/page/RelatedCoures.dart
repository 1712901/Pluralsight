import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

class RelatedCourse extends StatefulWidget {
  //final String categoryId;
  final List<CourseInfor> listCourse;

  const RelatedCourse({Key key, @required this.listCourse}) : super(key: key);
  @override
  _RelatedCourseState createState() => _RelatedCourseState();
}

class _RelatedCourseState extends State<RelatedCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(S.current.RelatedCourse),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
                    return CourseListTitle(
                      course: widget.listCourse[index],
                    );
                  },
                  itemCount: widget.listCourse.length,
      ),
    );
  }
}
