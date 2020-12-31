import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/Response/ResSearchV2.dart';
import 'package:Pluralsight/View/utils/Widget/AuthorListTitle.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  final Function(int index) funCallBack;
  final List<CourseInfor> courses;
  final List<InstructorSearchV2> authors;

  AllPage({this.funCallBack, this.courses,this.authors});

  @override
  _AllPageState createState() =>
      _AllPageState(funCallBack: funCallBack, courses: courses,authors: authors);
}

class _AllPageState extends State<AllPage> {
  List<String> list = ['1', '2', '3', '4'];
  final Function(int index) funCallBack;
  _AllPageState({this.funCallBack, this.courses,this.authors});
  final int numItems = 4;
  final List<CourseInfor> courses;
  final List<InstructorSearchV2> authors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Courses',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        funCallBack(1);
                      },
                      icon: Text(
                        'See all',
                      ),
                      label: Icon(Icons.navigate_next),
                      textColor: Colors.grey,
                      //onPressed: funCallBack(1),
                    )
                  ],
                ),
              ),
              Column(
                children: courses
                    .sublist(0,
                        courses.length <= numItems ? courses.length : numItems)
                    .map((course) => CourseListTitle(
                          course: course,
                        ))
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Authors',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        funCallBack(2);
                      },
                      icon: Text(
                        'See all',
                      ),
                      label: Icon(Icons.navigate_next),
                      textColor: Colors.grey,
                    )
                  ],
                ),
              ),
              Column(
                children: authors
                    .sublist(
                        0, authors.length <= numItems ? authors.length : numItems)
                    .map((author) => authorListTitle(context,author))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
