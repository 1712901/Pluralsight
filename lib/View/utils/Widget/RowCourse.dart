import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/View/utils/Widget/Courses.dart';
import 'package:Pluralsight/View/utils/page/MoreCourse.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

class RowCourse extends StatelessWidget {
  final String title;
  final List<CourseInfor> courses;
  final int type;

  const RowCourse({Key key, this.title, this.courses,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreCourse(
                              title: title,
                              type: type,
                            )));
              },
              icon: Text(S.current.SeeAll,style:Theme.of(context).textTheme.subtitle1,),
              label: Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
            )
          ],
        ),
        Courses(
          courses: courses,
        ),
      ],
    );
  }
}
