import 'dart:ui';

import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/FavoriteCourses.dart';
import 'package:Pluralsight/models/Format.dart';
import 'package:Pluralsight/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  final List<CourseInfor> courses;

  const Courses({Key key, this.courses}) : super(key: key);
  @override
  _CoursesState createState() => _CoursesState(courses: courses);
}

class _CoursesState extends State<Courses> {
  final List<CourseInfor> courses;
  List<CourseInfor> subCourse;
  _CoursesState({this.courses});
  @override
  Widget build(BuildContext context) {
    //subCourse = courses.sublist(0, courses.length >= 4 ? 4 : courses.length);
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return courseCard(course: courses[index]);
          }),
    );
  }

  Widget courseCard({CourseInfor course}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 220,
      color: Colors.grey[800],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseDetail(
                      course: course,
                    )));
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(course.imageUrl),
                          fit: BoxFit.cover)),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.2)
                          ])),
                      child: Consumer<FavoriteCourses>(
                        builder: (context, provider, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  alignment: Alignment.bottomRight,
                                  icon: provider.isFavorite(
                                              courseId: course.id) &&
                                          Provider.of<AccountInf>(context,
                                                  listen: false)
                                              .isAuthorization()
                                      ? Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        )
                                      : Icon(
                                          Icons.star_border_outlined,
                                          color: Colors.white,
                                        ),
                                  onPressed: () async {
                                    String token = Provider.of<AccountInf>(
                                            context,
                                            listen: false)
                                        .token;
                                    if (token != null) {
                                      Response res =
                                          await UserService.likeCourse(
                                              token: token,
                                              courseId: course.id);
                                      if (res.statusCode == 200) {
                                        provider.likeCourse(
                                            courseInfor: course);
                                      } else if (res.statusCode == 401) {
                                        Provider.of<AccountInf>(context,
                                                listen: false)
                                            .setToken(token: null);
                                        print('Chưa Đăng Nhập');
                                      }
                                    } else {
                                      print('Chưa Đăng Nhập');
                                    }
                                  })
                            ],
                          );
                        },
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              course.title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          course.instructorUserName,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          //width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${Format.getInstantDateFormat().format(course.updatedAt)}",
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                "${Format.printDuration(course.totalHours)}",
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating: (course.ratedNumber) * 1.0,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  //size: 15,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(5),
                                child: course.price == 0
                                    ? Text("Miễn Phí",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))
                                    : Text(NumberFormat.currency(locale: "vi")
                                        .format(course.price)),
                              )
                            ],
                          ),
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
