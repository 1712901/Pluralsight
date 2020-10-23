import 'package:Pluralsight/Components/AppBar.dart';
import 'package:Pluralsight/Components/Courses.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: myAppbar(title: title),
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
                        'Welcome to Pluraslight!',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                          'With Pluralsight, you can build and apply skills in top technologies. You have free access to skill IQ, Role IQ,a limited library of courses and a weekly rotation of new courses.',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListCourse(title: 'Software Development'),
              ListCourse(title: 'IT Operations'),
              ListCourse(title: 'Data Professional'),
              ListCourse(title: 'Security Professional'),
            ],
          ),
        ),
      ),
    );
  }

  Widget ListCourse({title}) {
    return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      FlatButton.icon(
                        onPressed: () {},
                        icon: Text('see all'),
                        label: Icon(
                          Icons.navigate_next,
                          color: Colors.grey,
                        ),
                        textColor: Colors.grey,
                      )
                    ],
                  ),
                  Courses(),
                ],
              );
  }
}
