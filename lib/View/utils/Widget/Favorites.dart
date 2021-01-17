import 'dart:ui';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/FavoriteCourse.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/utils/page/CourseDetail.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  final List<FavoriteCourse> courses;

  const Favorites({Key key, this.courses}) : super(key: key);
  @override
  _FavoritesState createState() => _FavoritesState(courses: courses);
}

class _FavoritesState extends State<Favorites> {
  final List<FavoriteCourse> courses;
  List<FavoriteCourse> subCourse;
  _FavoritesState({this.courses});
  @override
  Widget build(BuildContext context) {
    subCourse = courses.sublist(0, courses.length >= 4 ? 4 : courses.length);
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subCourse.length,
          itemBuilder: (context, index) {
            return favoriteCard(fav: subCourse[index]);
          }),
    );
  }

  Widget favoriteCard({FavoriteCourse fav}) {
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
                      course: fav.convertToCourseInfor(),
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
                          image: NetworkImage(fav.courseImage),
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
                                  icon: provider.isFavorite(courseId: fav.id) &&
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
                                              token: token, courseId: fav.id);
                                      if (res.statusCode == 200) {
                                        provider.likeCourse(
                                            courseInfor:
                                                fav.convertToCourseInfor());
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
                              fav.courseTitle,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                fav.instructorName,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              fav.coursePrice != null
                                  ? Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(5),
                                      child: fav.coursePrice == 0
                                          ? Text(S.current.Free,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))
                                          : Text(NumberFormat.currency(
                                                  locale: "vi")
                                              .format(fav.coursePrice)),
                                    )
                                  : Container()
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
