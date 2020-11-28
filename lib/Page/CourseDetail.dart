import 'package:Pluralsight/Page/AuthorDetail.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseDetail.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/models/LoadURL.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:android_intent/android_intent.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io' show Platform;
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:intent/extra.dart' as android_extra;
import 'package:provider/provider.dart';

class CourseDetail extends StatefulWidget {
  final CourseModel course;

  const CourseDetail({Key key, this.course}) : super(key: key);
  @override
  _CourseDetailState createState() => _CourseDetailState(course);
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  TabController primaryTC;
  bool maxLine = true;
  final CourseModel course;

  _CourseDetailState(this.course);

  @override
  void initState() {
    primaryTC = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CourseDetailModel courseDetail =
        Provider.of<CourseDetailListModel>(context,listen: false).getCourseDetail(course.ID);
    
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => LoadURL(url: courseDetail.urlCurrent),
        //builder: (context, child) => child,
        child: Scaffold(
            backgroundColor: Colors.black87,
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Stack(children: [
                        Consumer<LoadURL>(
                          builder: (context, provider, _) {
                            return Container(
                              child:
                                  Center(child: Text('URL :${provider.url}')),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                //alignment: Alignment.topLeft,
                                //padding: EdgeInsets.only(top: 25, left: 10)
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (Platform.isAndroid) {
                                      final AndroidIntent intent =
                                          AndroidIntent(
                                        action: 'action_send',
                                        //data: Uri.encodeFull('https://flutter.io'),
                                        //package: 'com.android.chrome'
                                      );
                                      intent.launch();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: extend.NestedScrollView(
                        headerSliverBuilder: (c, f) {
                          return [
                            SliverToBoxAdapter(
                              child: headerSilverAppBar(
                                  maxline: maxLine,
                                  course: course,
                                  courseDetail: courseDetail),
                            ),
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              pinned: true,
                              toolbarHeight: 0,
                              backgroundColor: Colors.grey[800],
                              bottom: TabBar(
                                controller: primaryTC,
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.white,
                                tabs: [
                                  Tab(text: "CONTENTS"),
                                  Tab(text: "TRANSCRIPT"),
                                ],
                              ),
                            )
                          ];
                        },
                        body: TabBarView(
                          controller: primaryTC,
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Column(
                                children: makeListContent(courseDetail),
                              ),
                            ),
                            Text('This is tab oe'),
                          ],
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget makeItemButton({Widget icon, String title, Function opTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: opTap,
        child: Container(
          height: 60,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                  child: Container(
                height: 35,
                color: Colors.grey,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: icon,
                ),
              )),
              Text(
                title,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> header() {
    List<Widget> list = [headerSilverAppBar(maxline: true)];
    return list;
  }

  Widget headerSilverAppBar(
      {bool maxline, CourseDetailModel courseDetail, CourseModel course}) {
        final List<AuthorModel> authors=Provider.of<AuthorsModel>(context,listen: false).getAllAuthor(course.ID);
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      color: Colors.grey[800],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.name,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemCount: authors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthorDetail(author: authors[index],)));
                },
                child: Chip(
                  padding: EdgeInsets.zero,
                  avatar: ClipOval(
                    child: Container(
                      color: Colors.orange,
                    ),
                  ),
                  label: Text(authors[index].name),
                ),
              );
            }),
          ),
          Row(
            children: [
              Text(
                'Intermediate - May 16 2018 3.6h',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 10,
              ),
              RatingBarIndicator(
                rating: course.rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
              Text(
                '(${course.numberComment})',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<CourseListModel>(builder: (context, provider, _) {
                return makeItemButton(
                    icon: Icon(course.bookmark
                        ? Icons.bookmark
                        : Icons.bookmark_outline),
                    title: course.bookmark ? 'Bookmarked' : 'Bookmark',
                    opTap: () {
                      provider.setBookmark(course.ID, !course.bookmark);
                    });
              }),
              makeItemButton(
                  icon: Icon(Icons.playlist_add),
                  title: 'Add to Channel',
                  opTap: () {
                    print("Add to Channel");
                    HandleAdd2Channel.openDialog(context, course.ID);
                  }),
              makeItemButton(
                  icon: Icon(Icons.arrow_circle_down),
                  title: 'Download',
                  opTap: () {
                    print("Download");
                    if (Provider.of<User>(context, listen: false)
                        .isAuthorization) {
                      Provider.of<DownloadModel>(context, listen: false)
                          .downloadCourse(course);
                      HandleAdd2Channel.showToast(context, "Downloading");
                      return;
                    }
                    HandleAdd2Channel.showToast(context, "Dowload failed");
                  }),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    child: Text(
                      courseDetail.description,
                      style: TextStyle(color: Colors.white),
                      maxLines: maxline ? 2 : null,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        maxLine = (!maxLine);
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      color: Theme.of(context).buttonColor,
                      child: Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.done_all),
                  label: Text('Take a learning check'))),
          SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.view_carousel),
                  label: Text('View related paths & courses'))),
        ],
      ),
    );
  }

  List<Column> makeListContent(CourseDetailModel courseDetail) {
    return courseDetail.modules
        .map((module) => Column(
              children: [
                ListTile(
                  title: Text(
                    module.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    module.getTotalTime().toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    color: Colors.orange,
                  ),
                  trailing: PopupMenuButton(
                      offset: Offset(0, 35),
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      color: Colors.grey[800],
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<int>>[
                          PopupMenuItem(
                              child: Text(
                            'Bookmark',
                            style: TextStyle(color: Colors.white),
                          )),
                          PopupMenuItem(
                              child: Text(
                            'Add to channel',
                            style: TextStyle(color: Colors.white),
                          )),
                          PopupMenuItem(
                              child: Text(
                            'Remove Download',
                            style: TextStyle(color: Colors.white),
                          )),
                        ];
                      }),
                ),
                Column(
                  children: module.contents
                      .map((content) =>
                          Builder(builder: (BuildContext newContext) {
                            return ListTile(
                              onTap: () {
                                newContext.read<LoadURL>().setUrl(content.url);
                              },
                              title: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.grey,
                                      size: 10,
                                    ),
                                  ),
                                  Text(
                                    content.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                content.time.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }))
                      .toList(),
                )
              ],
            ))
        .toList();
  }
}
