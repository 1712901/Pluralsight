import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Response/ResGetAllCategory.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/Response/ResHistory.dart';
import 'package:Pluralsight/Core/models/Response/ResSearch.dart';
import 'package:Pluralsight/Core/models/Response/ResSearchV2.dart';
import 'package:Pluralsight/Core/models/SearchBuilder/PriceOption.dart';
import 'package:Pluralsight/Core/models/SearchBuilder/SearchOption.dart';
import 'package:Pluralsight/Core/models/SearchBuilder/TimeOption.dart';
import 'package:Pluralsight/Core/models/SearchMode.dart';
import 'package:Pluralsight/Core/service/CategoryService.dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/View/ui/Constant.dart';
import 'package:Pluralsight/View/ui/Search/Widget/AllPage.dart';
import 'package:Pluralsight/View/ui/Search/Widget/AuthourPage.dart';
import 'package:Pluralsight/View/ui/Search/Widget/CoursesPage.dart';
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
  ScrollController scrollController;

  String query = "";
  bool searchResult = false;
  bool isloading = false;
  bool isLoadMore = true;
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
  SearchOption searchOption = null;

  final List<String> listTile = ['ALL', 'COURSES', 'AUTHOURS'];
  //Save data search
  List<CourseInfor> courses = [];
  int offset = 0;
  //
  List<InstructorSearchV2> instructors = [];
  List<Time> timeOption = [];
  List<Price> priceOption = [];
  List<String> categoryOption = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: listTile.length);
    scrollController = new ScrollController()..addListener(_scrollListener);
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
        appBar: AppBar(
          elevation: 0,
          title: TextField(
            autofocus: findkey,
            controller: _controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded, color: Theme.of(context).iconTheme.color),
              hintText: 'Search...',
              hintStyle:Theme.of(context).textTheme.subtitle2,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color:Theme.of(context).iconTheme.color,
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
            style: Theme.of(context).textTheme.subtitle1,
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
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }

  Widget searchView() {
    return findkey ? searchResultView() : searchRecentView();
  }

  Widget tabBarView(List<CourseInfor> list) {
    bool isEmpty = list.length == 0;
    return !isEmpty
        ? TabBarView(
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
                scrollController: scrollController,
              ),
              AuthourPage(authors: instructors),
            ],
          )
        : Container(
            child: Center(
              child: Text(
                "Không tìm thấy kết quả",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
  }

  Widget tabBar() {
    return TabBar(
        controller: _tabController,
        //indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Theme.of(context).scaffoldBackgroundColor),
        labelPadding: EdgeInsets.all(10),
        tabs: [
          Text('ALL',style: Theme.of(context).textTheme.bodyText1,),
          Text('COURSES',style: Theme.of(context).textTheme.bodyText1),
          Text('AUTHORS',style: Theme.of(context).textTheme.bodyText1),
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

  void setOption({List<String> catrgory, List<Time> time, List<Price> price}) {
    priceOption.clear();
    timeOption.clear();
    categoryOption.clear();
    if(price!=null) priceOption.addAll(price);
    if(time!=null) timeOption.addAll(time);
    if(catrgory!=null) categoryOption.addAll(catrgory);
  }

  Future<void> onSubmitted(String text,
      {List<String> catrgory, List<Time> time, List<Price> price}) async {
    setState(() {
      isloading = true;
      findkey = false;
    });
    setOption(catrgory: catrgory,time: time,price: price);
    Response res = await search(
        text, catrgory, time, price, 0, ConstanUI.SEARCH_LIMIT); // loading
    if (res.statusCode == 200) {
      if (!islogin) {
        ResSearch resSearch = ResSearch.fromJson(jsonDecode(res.body));
        courses = resSearch.payload.courses;
      } else {
        ResSearchV2 resSearchV2 = ResSearchV2.fromJson(jsonDecode(res.body));
        this.courses = resSearchV2.payload.courses.data;
        this.instructors = resSearchV2.payload.instructors.data;
      }
    }
    setState(() {
      isloading = false;
      searchResult = true;
    });
  }

  Future<Response> search(String text, List<String> catrgory, List<Time> time,
      List<Price> price, int offset, int limit) async {
    isLoadMore = true;
    if (!islogin) {
      // dùng Search
      return CourseService.search(
          keyword: text,
          offset: offset,
          limit: limit,
          opt: Opt(
              sort: Sort(attribute: "price", rule: "ASC"),
              category: catrgory,
              time: time,
              price: price));
    } else {
      // dùng SearchV2
      return CourseService.searchV2(
          keyword: text,
          offset: offset,
          limit: limit,
          token: Provider.of<AccountInf>(context, listen: false).token,
          opt: Opt(
              sort: Sort(attribute: "price", rule: "ASC"),
              category: catrgory,
              time: time,
              price: price));
    }
  }

  Future<void> searchMore(SearchOption searchOption) async {
    print("Searmore");
    offset = courses.length + 1;
    // SearchOption searchOption =
    //     Provider.of<SearchOption>(context, listen: false);
    Response res = await search(
        _controller.text,
        this.categoryOption,
        this.timeOption,
        this.priceOption,
        offset,
        ConstanUI.SEARCH_LIMIT); // loading
    if (res.statusCode == 200) {
      if (!islogin) {
        ResSearch resSearch = ResSearch.fromJson(jsonDecode(res.body));
        courses.addAll(resSearch.payload.courses);
        if (resSearch.payload.courses.length < ConstanUI.SEARCH_LIMIT - 1) {
          isLoadMore = false;
        }
      } else {
        ResSearchV2 resSearchV2 = ResSearchV2.fromJson(jsonDecode(res.body));
        courses.addAll(resSearchV2.payload.courses.data);
        if (resSearchV2.payload.courses.data.length <
            ConstanUI.SEARCH_LIMIT - 1) {
          isLoadMore = false;
        }
        this.instructors.addAll(resSearchV2.payload.instructors.data);
      }
    }
    setState(() {});
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        isLoadMore) {
      await searchMore(this.searchOption);
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
                          SearchOption searchOption=Provider.of<SearchOption>(context,listen: false);
                          await onSubmitted(list[index].content,catrgory: searchOption.getCategory(),time: searchOption.getTimes(),price: searchOption.getPrice());
                          _controller.text = list[index].content;
                        },
                        leading: Icon(
                          Icons.history,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        title: Text(
                          list[index].content,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).iconTheme.color,
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
              }else{
                return Container();
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
      builder: (context) => AlertDialog(
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
                    Provider.of<SearchOption>(context, listen: false)
                        .getCategory();
                List<Time> time =
                    Provider.of<SearchOption>(context, listen: false)
                        .getTimes();
                List<Price> price =
                    Provider.of<SearchOption>(context, listen: false)
                        .getPrice();
                searchResult = false;
                onSubmitted(_controller.text,
                    price: price, catrgory: category, time: time);
                Navigator.of(context).pop(false);
              },
              child: Text("OK")),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel")),
        ],
      ),
    );
  }
}
