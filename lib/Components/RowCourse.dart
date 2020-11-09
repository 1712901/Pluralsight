import 'package:Pluralsight/Components/Courses.dart';
import 'package:Pluralsight/Page/MoreCourse.dart';
import 'package:flutter/material.dart';

class RowCourse extends StatelessWidget {
  final String title;

  const RowCourse({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  //fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreCourse(
                              title: title,
                            )));
              },
              icon: Text('see all'),
              label: Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
              textColor: Colors.grey,
            )
          ],
        ),
        Courses(),
      ],
    );
  }
}
