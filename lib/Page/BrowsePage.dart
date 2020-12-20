import 'dart:convert';

import 'package:Pluralsight/Components/AppBar.dart';
import 'package:Pluralsight/Components/RowCourse.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/Browse/BrMoreCourse.dart';
import 'package:Pluralsight/Page/Browse/CategoryPage.dart';
import 'package:Pluralsight/Page/Browse/MorePath.dart';
import 'package:Pluralsight/Page/Browse/PathsPage.dart';
import 'package:Pluralsight/Page/Browse/RowAuthorsView.dart';
import 'package:Pluralsight/Page/Browse/SkillDetail.dart';
import 'package:Pluralsight/Page/PathDetail.dart';
import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Response/ResGetAllCategory.dart';
import 'package:Pluralsight/service/CategoryService.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:Pluralsight/models/CourseList.dart';

class BrowsePase extends StatelessWidget {
  final List<String> categoryImg = [
    "assets/images/DownloadPage/category1.jpg",
    "assets/images/DownloadPage/category2.jpg",
    "assets/images/DownloadPage/category3.jpg",
    "assets/images/DownloadPage/category4.jpg",
    "assets/images/DownloadPage/category4.jpg",
    "assets/images/DownloadPage/category1.jpg",
  ];
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
      appBar: myAppbar(title: 'Browse', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrMoreCourse(
                                title: 'NEW RELEASES',
                                type: CourseService.TOP_NEW,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      //color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/DownloadPage/new-releases.jpg"),
                          fit: BoxFit.cover)),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.4)
                    ])),
                    child: Text(
                      'NEW \nRELEASES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (!Provider.of<AccountInf>(context, listen: false)
                      .isAuthorization()) {
                    print("Chưa đăng nhập");
                    return;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrMoreCourse(
                                title: 'RECOMMENDED FOR YOU',
                                type: -1,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/DownloadPage/recommended.jpg"),
                          fit: BoxFit.cover)),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.4)
                    ])),
                    child: Text(
                      'RECOMMENDED \nFOR YOU',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: CategoryService.getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Response res = snapshot.data;
                      ResGetAllCategory resGetAllCategory;
                      if (res.statusCode == 200) {
                        resGetAllCategory =
                            ResGetAllCategory.fromJson(jsonDecode(res.body));
                        return Container(
                          height: 200,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            children: resGetAllCategory.category
                                .asMap()
                                .map((index, item) {
                                  return MapEntry(
                                      index,
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridTile(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CategoryPage(
                                                            category: item,
                                                            image: 'assets/images/DownloadPage/category${index % 4 + 1}.jpg',
                                                          )));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/DownloadPage/category${index % 4 + 1}.jpg'),
                                                      fit: BoxFit.cover)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        LinearGradient(colors: [
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.black.withOpacity(0.5)
                                                ])),
                                                child: Align(
                                                    child: Text(
                                                  '${item.name}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                })
                                .values
                                .toList(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
              SizedBox(
                height: 15,
              ),
              Text(
                'Popular Skill',
                style: TextStyle(color: Colors.white),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: skills.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            print(skills[index].toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SkillDetail(
                                          title: skills[index].toString(),
                                        )));
                          },
                          child: Chip(
                              backgroundColor: Colors.grey[800],
                              label: Text(
                                '${skills[index]}',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      );
                    }),
              ),
              //RowCourse(title: 'Trending',courses: Provider.of<CourseListModel>(context).findByTag('Java'),),
              SizedBox(
                height: 15,
              ),
              RowAuthorsView(
                title: 'Top auhors',
                authors: Provider.of<AuthorsModel>(context).authors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

