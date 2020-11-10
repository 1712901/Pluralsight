import 'package:Pluralsight/Components/AuthorListTitle.dart';
import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/Components/PathListTitle.dart';
import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  final Function(int index) funCallBack;

  AllPage({this.funCallBack});

  @override
  _AllPageState createState() => _AllPageState(funCallBack: funCallBack);
}

class _AllPageState extends State<AllPage> {
  List<String> list = ['1', '2', '3', '4'];
  final Function(int index) funCallBack;
  _AllPageState({this.funCallBack});
  final int numItems = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Courses',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        funCallBack(1);
                      },
                      icon: Text(
                        'See all',
                      ),
                      label: Icon(Icons.navigate_next),
                      textColor: Colors.grey,
                      //onPressed: funCallBack(1),
                    )
                  ],
                ),
              ),
              Column(
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => CourseListTitle())
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Path',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        funCallBack(2);
                      },
                      icon: Text(
                        'See all',
                      ),
                      label: Icon(Icons.navigate_next),
                      textColor: Colors.grey,
                    )
                  ],
                ),
              ),
              Column(
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => pathListTile())
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Authors',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        funCallBack(3);
                      },
                      icon: Text(
                        'See all',
                      ),
                      label: Icon(Icons.navigate_next),
                      textColor: Colors.grey,
                    )
                  ],
                ),
              ),
              Column(
                children: list
                    .sublist(
                        0, list.length <= numItems ? list.length : numItems)
                    .map((item) => authorListTitle(context))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
