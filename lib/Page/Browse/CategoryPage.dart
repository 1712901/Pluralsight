import 'package:Pluralsight/Components/RowCourse.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/Browse/SkillDetail.dart';
import 'package:flutter/material.dart';
import 'package:Pluralsight/Page/BrowsePage.dart';

import 'RowAuthorsView.dart';

class CategoryPage extends StatelessWidget {
  final Category category;

  CategoryPage({Key key, this.category}) : super(key: key);
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
                      image: AssetImage(category.image), fit: BoxFit.cover),
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
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${category.name} Skill',
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
                  RowPathView(
                    title: 'Paths in ${category.name}',
                  ),
                  RowCourse(
                    title: 'New in ${category.name}',
                  ),
                  RowCourse(
                    title: 'Trending in ${category.name}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RowAuthorsView(
                    title: 'Top authors in Software Development',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
