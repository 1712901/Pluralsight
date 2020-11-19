import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return courseCard(index: index);
          }),
    );
  }

  Widget courseCard({index}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 220,
      color: Colors.grey[800],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CourseDetail()));
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
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            color: Colors.grey[800],
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<FlatButton>>[
                                PopupMenuItem(
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Bookmark',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                PopupMenuItem(
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Add to channel',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                PopupMenuItem(
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Download',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                PopupMenuItem(
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Share',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.white),
                                        ))),
                              ];
                            }),
                        IconButton(
                            alignment: Alignment.bottomRight,
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Angular Fundamentals',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Joe Eames',
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
                              rating: 3.45,
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
                              '(555)',
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
