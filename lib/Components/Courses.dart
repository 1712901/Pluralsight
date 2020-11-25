import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  final int type;

  const Courses({Key key, this.type}) : super(key: key);
  @override
  _CoursesState createState() => _CoursesState(type: type);
}

class _CoursesState extends State<Courses> {
  List<Course> _list;
  CourseList courseList;
  final int type;

  _CoursesState({this.type});
  @override
  Widget build(BuildContext context) {
    courseList = Provider.of<CourseList>(context,listen: false);
    _list = courseList.couserList
        .where((element) => element.category == type)
        .toList();
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return courseCard(course: _list[index]);
          }),
    );
  }

  Widget courseCard({Course course}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 220,
      color: Colors.grey[800],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CourseDetail()));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.2)
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                            offset: Offset(0, 35),
                            onSelected: (index) {
                              switch (index) {
                                case 0:
                                  courseList.setBookmark(
                                      course.ID, !course.bookmark);
                                  break;
                                default:
                              }
                            },
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            color: Colors.grey[800],
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem(
                                    value: 0,
                                    child: Text(
                                      'Bookmark',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                      'Add to channel',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                PopupMenuItem(
                                    value: 2,
                                    child: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                PopupMenuItem(
                                    value: 3,
                                    child: Text(
                                      'Share',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ];
                            }),
                        Consumer<CourseList>(
                          builder: (context, provider, _) {
                            return IconButton(
                                alignment: Alignment.bottomRight,
                                icon: Icon(
                                  course.bookmark
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  courseList.setBookmark(
                                      course.ID, !course.bookmark);
                                });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          course.author,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          //width: 200,
                          child: Text(
                            'Intermediate - Feb_2019 - 9h35m',
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: course.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                //size: 15,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              '(${course.numberComment})',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
