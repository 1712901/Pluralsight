import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  final List<CourseInfor> list;
  final ScrollController scrollController;

  const CoursesPage({Key key, this.list,this.scrollController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${list.length} Results',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Flexible(
            child: ListView.builder(
              controller: scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CourseListTitle(
                      course: list[index],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
