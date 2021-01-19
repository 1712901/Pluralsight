import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/FavoriteCourse.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/View/utils/Widget/AppBar.dart';
import 'package:Pluralsight/View/utils/Widget/RowCourse.dart';
import 'package:Pluralsight/View/utils/Widget/RowFavorite.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black54,
      appBar: myAppbar(title: title, context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        S.current.TitleIntro,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                          S.current.Intro,
                          style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: CourseService.getTopSell(limit: 4, page: 1),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    Response response = snapshot.data;
                    if (response.statusCode == 200) {
                      ResGetTopCourse resGetTopSell =
                          ResGetTopCourse.fromJson(jsonDecode(response.body));
                      return RowCourse(
                        title: S.current.TopSell,
                        courses: resGetTopSell.courses,
                        type: CourseService.TOP_SELL,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder(
                future: CourseService.getTopNew(limit: 4, page: 1),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    Response response = snapshot.data;
                    if (response.statusCode == 200) {
                      ResGetTopCourse resGetTopSell =
                          ResGetTopCourse.fromJson(jsonDecode(response.body));
                      return RowCourse(
                        title: S.current.TopNew,
                        courses: resGetTopSell.courses,
                        type: CourseService.TOP_NEW,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              FutureBuilder(
                future: CourseService.getTopRate(limit: 4, page: 1),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    Response response = snapshot.data;
                    if (response.statusCode == 200) {
                      ResGetTopCourse resGetTopSell =
                          ResGetTopCourse.fromJson(jsonDecode(response.body));
                      return RowCourse(
                        title: S.current.TopRating,
                        courses: resGetTopSell.courses,
                        type: CourseService.TOP_RATE,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              Consumer<FavoriteCourses>(builder: (ctx, provider, _) {
                List<FavoriteCourse> list = provider.favoriteCourses;
                return Provider.of<AccountInf>(ctx).isAuthorization() &&
                        list != null
                    ? RowFavoriteCourses(
                        title: S.current.MyFavorite,
                        favoriteCourses: list)
                    : Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
