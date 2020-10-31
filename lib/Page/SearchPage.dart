import 'package:Pluralsight/Page/Search/AllPage.dart';
import 'package:Pluralsight/Page/Search/AuthourPage.dart';
import 'package:Pluralsight/Page/Search/CoursesPage.dart';
import 'package:Pluralsight/Page/Search/PathPage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int initPage = 0;
  final _controller = PageController(
    initialPage: 0,
  );
  final List<String> listTile = ['ALL', 'COURSES', 'PATHS', 'AUTHOURS'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              hintStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              color: Colors.black
            ),
            labelPadding: EdgeInsets.all(10),
              tabs: [
              Text('ALL'),
              Text('COURSES'),
              Text('PATHS'),
              Text('AUTHORS'),
            ]),
        ),
        body: TabBarView(
          children: [
            AllPage(),
            CoursesPage(),
            PathPage(),
            AuthourPage(),
          ],
        ),
      ),
    );
  }
}
