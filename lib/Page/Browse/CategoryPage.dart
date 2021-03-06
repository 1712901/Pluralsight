import 'dart:convert';

import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/Components/RowCourse.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/Browse/SkillDetail.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/Response/ResGetAllCategory.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/models/Response/ResSearch.dart';
import 'package:Pluralsight/service/CategoryService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'RowAuthorsView.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  final String image;

  CategoryPage({Key key, this.category, this.image}) : super(key: key);
  final List<String> skills = [
    'C++',
    'javaScrip',
    'Java',
    'NodeJs',
    'Angular',
    'Data Analysis',
    'Design Patterns',
    'Python',
    '.NET',
    'SQL',
    'React',
    'Android',
    'Machine Learning'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[800],
            title: Text(category.name),
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.3)
                      ])),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: FutureBuilder(
                future: CategoryService.getCourseByCategory(
                    courseId: category.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Response res = snapshot.data;
                    ResSearch resSearch =
                        ResSearch.fromJson(jsonDecode(res.body));
                    print(resSearch.payload.count);
                    List<CourseInfor> courses = resSearch.payload.courses;
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => CourseListTitle(
                                  course: courses[index],
                                ),
                            childCount: courses.length));
                  } else {
                    return SliverFillRemaining(
                                          child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ),
    
        ],
      ),
    );
  }
}
