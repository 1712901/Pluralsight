import 'package:Pluralsight/Components/AuthorListTitle.dart';
import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/Components/PathListTitle.dart';
import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:flutter/material.dart';

class AllPage extends StatelessWidget {
  List<String> list = ['1', '2', '3', '4'];
  final int numItems = 4;
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
                      onPressed: () {},
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
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => CourseListTitle())
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Path',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
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
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => pathListTile())
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
                      onPressed: () {},
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
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => authorListTitle())
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
