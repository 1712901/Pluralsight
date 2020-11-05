import 'package:Pluralsight/Page/Search/AllPage.dart';
import 'package:Pluralsight/Page/Search/AuthourPage.dart';
import 'package:Pluralsight/Page/Search/CoursesPage.dart';
import 'package:Pluralsight/Page/Search/PathPage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  //int initPage = 0;
  TabController _tabController;
  String query = "";
  bool searchResult = false;
  bool finding = false;

  List<String> recents = ["Android", "C#", "Java"];
  List<String> dataSearch = [
    "Android",
    "C#",
    "Java",
    "HTML/CSS",
    "Nodejs",
    "C/C++",
    "Design parttern"
  ];
  List<String> showData;
  TextEditingController _controller;

  final List<String> listTile = ['ALL', 'COURSES', 'PATHS', 'AUTHOURS'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: listTile.length);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

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
            controller: _controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey,
                ),
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    query = "";
                  });
                },
              ),
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
            onChanged: onChangeText,
            onSubmitted: onSubmitted,
          ),
          bottom: !searchResult ? null : tabBar(),
        ),
        body: !searchResult ? searchView() : tabBarView(),
      ),
    );
  }

  Widget searchView() {
    return finding ? searchResultView() : searchRecentView();
  }

  Widget tabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        AllPage(
          funCallBack: (index) {
            _tabController.animateTo(index);
          },
        ),
        CoursesPage(),
        PathPage(),
        AuthourPage(),
      ],
    );
  }

  Widget tabBar() {
    return TabBar(
        controller: _tabController,
        //indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.black),
        labelPadding: EdgeInsets.all(10),
        tabs: [
          Text('ALL'),
          Text('COURSES'),
          Text('PATHS'),
          Text('AUTHORS'),
        ]);
  }

  void onChangeText(String text) {
    if (text.isEmpty) {
      setState(() {
        finding = false;
      });
    } else {
      setState(() {
        searchResult = false;
        finding = true;
        showData = dataSearch
            .where((element) =>
                element.toUpperCase().startsWith(text.toUpperCase()))
            .toList();
      });
    }
  }

  void onSubmitted(String text) {
    setState(() {
      recents.add(text);
    });
  }

  Widget searchRecentView() {
    return ListView.builder(
        itemCount: recents.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              setState(() {
                searchResult = true;
                _controller.text = recents[index].toString();
              });
            },
            leading: Icon(
              Icons.history,
              color: Colors.white,
            ),
            title: Text(
              recents[index].toString(),
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                recents.removeAt(index);
                setState(() {});
              },
            ),
          );
        });
  }

  Widget searchResultView() {
    return ListView.builder(
        itemCount: showData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              setState(() {
                searchResult = true;
                _controller.text = showData[index].toString();
              });
            },
            title: Text(
              showData[index].toString(),
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }
}
