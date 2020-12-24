import 'dart:convert';

import 'package:Pluralsight/Page/Search/AllPage.dart';
import 'package:Pluralsight/Page/Search/AuthourPage.dart';
import 'package:Pluralsight/Page/Search/CoursesPage.dart';
import 'package:Pluralsight/Page/Search/PathPage.dart';
import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/Response/ResGetAllCategory.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/models/Response/ResHistory.dart';
import 'package:Pluralsight/models/Response/ResSearch.dart';
import 'package:Pluralsight/models/Response/ResSearchV2.dart';
import 'package:Pluralsight/models/SearchBuilder/PriceOption.dart';
import 'package:Pluralsight/models/SearchBuilder/SearchOption.dart';
import 'package:Pluralsight/models/SearchBuilder/TimeOption.dart';
import 'package:Pluralsight/models/SearchMode.dart';
import 'package:Pluralsight/service/CategoryService.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

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
  bool isloading = false;
  bool findkey = false;
  bool islogin = false;
  List<String> recents = ["Android", "C#", "Java"];
  List<String> dataSearch = [
    "Android",
    "IOS",
    "Flutter",
    "C#",
    "Java",
    "HTML/CSS",
    "Nodejs",
    "APS.NET",
    "Design parttern"
  ];
  List<String> showData;
  TextEditingController _controller;

  final List<String> listTile = ['ALL', 'COURSES', 'AUTHOURS'];
  List<CourseInfor> courses = [];
  List<InstructorSearchV2> instructors = [];
  List<Time> timeOption = [];
  List<Price> priceOption = [];

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
    islogin = Provider.of<AccountInf>(context, listen: false).isAuthorization();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          title: TextField(
            autofocus: findkey,
            controller: _controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
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
                    findkey = false;
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
        body: !searchResult ? searchView() : tabBarView(courses),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAlert(context);
          },
          child: Icon(Icons.filter_list_outlined),
          backgroundColor: Colors.grey[800],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }

  Widget searchView() {
    return findkey ? searchResultView() : searchRecentView();
  }

  Widget tabBarView(List<CourseInfor> list) {
    return TabBarView(
      controller: _tabController,
      children: [
        AllPage(
          funCallBack: (index) {
            _tabController.animateTo(index);
          },
          courses: list,
          authors: instructors,
        ),
        CoursesPage(
          list: list,
        ),
        AuthourPage(authors: instructors),
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
          Text('AUTHORS'),
        ]);
  }

  void onChangeText(String text) {
    if (text.isEmpty) {
      setState(() {
        findkey = false;
      });
    } else {
      setState(() {
        searchResult = false;
        findkey = true;
        showData = dataSearch
            .where((element) =>
                element.toUpperCase().startsWith(text.toUpperCase()))
            .toList();
      });
    }
  }

  Future<void> onSubmitted(String text,
      {List<String> catrgory, List<Time> time, List<Price> price}) async {
    setState(() {
      isloading = true;
      findkey = false;
    });
    if (!islogin) {
      // dùng Search
      Response res = await CourseService.search(
          keyword: text,
          opt: Opt(
              sort: Sort(attribute: "price", rule: "ASC"),
              category: catrgory,
              time: time,
              price: price));
      if (res.statusCode == 200) {
        ResSearch resSearch = ResSearch.fromJson(jsonDecode(res.body));
        courses = resSearch.payload.courses;
         setState(() {
        isloading = false;
        searchResult = true;
      });
      }
    } else {
      // dùng SearchV2
      Response res = await CourseService.searchV2(
          keyword: text,
          token: Provider.of<AccountInf>(context, listen: false).token,
          opt: Opt(
              sort: Sort(attribute: "price", rule: "ASC"),
              category: catrgory,
              time: time,
              price: price));
      if (res.statusCode == 200) {
        ResSearchV2 resSearchV2 = ResSearchV2.fromJson(jsonDecode(res.body));
        this.courses = resSearchV2.payload.courses.data;
        this.instructors = resSearchV2.payload.instructors.data;
      }
      setState(() {
        isloading = false;
        searchResult = true;
      });
    }
  }

  Widget searchRecentView() {
    if (islogin) {
      return FutureBuilder(
          future: CourseService.getHistory(
              token: Provider.of<AccountInf>(context, listen: false).token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Response res = snapshot.data;
              if (res.statusCode == 200) {
                ResHistory resHistory =
                    ResHistory.fromJson(jsonDecode(res.body));
                List<History> list = resHistory.payload.data;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          await onSubmitted(list[index].content);
                          _controller.text = list[index].content;
                        },
                        leading: Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                        title: Text(
                          list[index].content,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () async {
                            await CourseService.deleteHistory(
                                historyID: list[index].id,
                                token: Provider.of<AccountInf>(context,
                                        listen: false)
                                    .token);
                            setState(() {});
                          },
                        ),
                      );
                    });
              }
            } else {
              return Container();
            }
          });
    } else {
      return Container();
    }
  }

  Widget searchResultView() {
    if (!isloading) {
      return ListView.builder(
          itemCount: showData.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                print(showData[index].toString());
                _controller.text = showData[index].toString();
                await onSubmitted(showData[index].toString());
              },
              title: Text(
                showData[index].toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
          });
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future _showAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (contextDialog) => AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        content: Consumer<SearchOption>(
          builder: (context, provider, _) => Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Center(
                          child: Text("Thời Lượng",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    IconButton(
                        padding: EdgeInsets.only(right: 20),
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.clearTime();
                        })
                  ],
                ),
                Divider(),
                Column(
                  children: TimeOption.option
                      .map((key, time) => MapEntry(
                          key,
                          CheckboxListTile(
                            title: Text(key),
                            value: provider.containsTime(time: time),
                            onChanged: (value) {
                              if (value) {
                                provider.addTime(time: time);
                              } else {
                                provider.removeTime(time: time);
                              }
                            },
                          )))
                      .values
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Center(
                          child: Text("Học Phí",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    IconButton(
                        padding: EdgeInsets.only(right: 20),
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.clearPrice();
                        })
                  ],
                ),
                Divider(),
                Column(
                  children: PriceOption.option
                      .map((key, price) => MapEntry(
                          key,
                          CheckboxListTile(
                            title: Text(key),
                            value: provider.containsPrice(price: price),
                            onChanged: (value) {
                              if (value) {
                                provider.addPrice(price: price);
                              } else {
                                provider.removePrice(price: price);
                              }
                            },
                          )))
                      .values
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Center(
                          child: Text("Chủ đề",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    IconButton(
                        padding: EdgeInsets.only(right: 20),
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.clearCatgory();
                        })
                  ],
                ),
                Divider(),
                FutureBuilder(
                    future: CategoryService.getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Response res = snapshot.data;
                        if (res.statusCode == 200) {
                          ResGetAllCategory resGetAllCategory =
                              ResGetAllCategory.fromJson(jsonDecode(res.body));
                          List<Category> listCategory =
                              resGetAllCategory.category;
                          return Column(
                              children: listCategory
                                  .map((e) => CheckboxListTile(
                                        title: Text(e.name),
                                        value: provider.containsCategory(
                                            categoryId: e.id),
                                        onChanged: (value) {
                                          if (value) {
                                            provider.addCategory(
                                                categoryId: e.id);
                                          } else {
                                            provider.removeCategory(
                                                categoryId: e.id);
                                          }
                                        },
                                      ))
                                  .toList());
                        } else {
                          return Container();
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                List<String> category =
                    Provider.of<SearchOption>(contextDialog, listen: false)
                        .getCategory();
                List<Time> time =
                    Provider.of<SearchOption>(contextDialog, listen: false)
                        .getTimes();
                List<Price> price =
                    Provider.of<SearchOption>(contextDialog, listen: false)
                        .getPrice();
                searchResult = false;
                onSubmitted(_controller.text,
                    price: price, catrgory: category, time: time);
                Navigator.of(contextDialog).pop(false);
              },
              child: Text("OK")),
          FlatButton(
              onPressed: () {
                Navigator.of(contextDialog).pop(false);
              },
              child: Text("Cancel")),
        ],
      ),
    );
  }
}
