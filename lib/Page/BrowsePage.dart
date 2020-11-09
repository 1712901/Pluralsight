import 'package:Pluralsight/Components/AppBar.dart';
import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:Pluralsight/Page/Browse/BrMoreCourse.dart';
import 'package:Pluralsight/Page/Browse/RowAuthorsView.dart';
import 'package:flutter/material.dart';

class BrowsePase extends StatelessWidget {
  final List<Catelogy> category = [
    Catelogy(
        image: "assets/images/DownloadPage/category1.jpg", name: "CONFERENCES"),
    Catelogy(image: "assets/images/DownloadPage/category3.jpg", name: "IO OPS"),
    Catelogy(
        image: "assets/images/DownloadPage/category2.jpg",
        name: "CERTIFICATIONS"),
    Catelogy(
        image: "assets/images/DownloadPage/category4.jpg",
        name: "DATA\nPROFESSIONAL"),
    Catelogy(
        image: "assets/images/DownloadPage/category4.jpg",
        name: "CREATIVE\nPROFESSIONAL"),
    Catelogy(
        image: "assets/images/DownloadPage/category1.jpg",
        name: "DESIGN\nPATTERNS"),
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
      appBar: myAppbar(title: 'Browse'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BrMoreCourse(title:'NEW RELEASES')));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BrMoreCourse(title:'RECOMMENDED FOR YOU')));
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
                        //color: Colors.white,
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
                              '${item.name}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
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
              RowPathView(),
              SizedBox(
                height: 15,
              ),
              RowAuthorsView(),
              
            ],
          ),
        ),
      ),
    );
  }
}

class Catelogy {
  String name;
  String image;
  Catelogy({this.name, this.image});
}
