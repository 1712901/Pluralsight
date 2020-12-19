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
import 'package:Pluralsight/models/Author.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Pluralsight/models/CourseList.dart';

class BrowsePase extends StatelessWidget {
  final List<Category> category = [
    Category(
        image: "assets/images/DownloadPage/category1.jpg", title: "CONFERENCES",name: "Conferences"),
    Category(image: "assets/images/DownloadPage/category3.jpg", title: "IT OPS",name: "IT Ops"),
    Category(
        image: "assets/images/DownloadPage/category2.jpg",
        title: "CERTIFICATIONS",name: "Certifications"),
    Category(
        image: "assets/images/DownloadPage/category4.jpg",
        title: "DATA\nPROFESSIONAL",name: "Data Professional"),
    Category(
        image: "assets/images/DownloadPage/category4.jpg",
        title: "CREATIVE\nPROFESSIONAL",name: "Creative Professsional"),
    Category(
        image: "assets/images/DownloadPage/category1.jpg",
        title: "DESIGN\nPATTERNS",name: "Design Patterns"),
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
      appBar: myAppbar(title: 'Browse',context: context),
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
                          builder: (context) =>
                              BrMoreCourse(title: 'NEW RELEASES',
                              courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(2),)));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BrMoreCourse(title: 'RECOMMENDED FOR YOU',
                              courses: Provider.of<CourseListModel>(context,listen: false).getCoursesByCate(1),)));
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
              Container(
                height: 200,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  children: category.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryPage(
                                          category: item,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('${item.image}'),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.5)
                              ])),
                              child: Align(
                                  child: Text(
                                '${item.title}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
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

class Category {
  String name;
  String image;
  String title;
  Category({this.name, this.image, this.title});
}
