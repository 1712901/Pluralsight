import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MoreCourse extends StatelessWidget {
  final String title;

  const MoreCourse({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              return CourseListTitle();
            },
            itemCount: 10,
          ),
        ));
  }
}
