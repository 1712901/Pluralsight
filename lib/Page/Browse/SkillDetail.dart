import 'package:Pluralsight/Components/RowCourse.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/Browse/RowAuthorsView.dart';
import 'package:flutter/material.dart';

class SkillDetail extends StatelessWidget {
  final String title;

  const SkillDetail({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(title),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowPathView(
                title: 'Paths in ${title}',
              ),
              RowCourse(
                title: 'New in ${title}',
              ),
              RowCourse(
                title: 'Trending in ${title}',
              ),
              SizedBox(height: 10,),
              RowAuthorsView(
                title: 'Top authors in Software Development',
              )
            ],
          ),
        ),
      ),
    );
  }
}
