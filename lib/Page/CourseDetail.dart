import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourseDetail extends StatefulWidget {
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  TabController primaryTC;
  bool maxLine = true;

  List<SubContent> list = [
    SubContent(title: "abc", time: 60, list: [
      Content(title: "abc1", time: 20),
      Content(title: "abc2", time: 20),
      Content(title: "abc3", time: 20),
    ]),
    SubContent(title: "abcd", time: 60, list: [
      Content(title: "abcd1", time: 20),
      Content(title: "abcd2", time: 20),
      Content(title: "abcd3", time: 20),
    ]),
    SubContent(title: "abcde", time: 60, list: [
      Content(title: "abcde1", time: 20),
      Content(title: "abcde2", time: 20),
      Content(title: "abcde3", time: 20),
    ]),
  ];

  @override
  void initState() {
    primaryTC = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.orange,
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 25, left: 10)),
              ),
              Flexible(
                child: extend.NestedScrollView(
                    headerSliverBuilder: (c, f) {
                      return <Widget>[
                        SliverAppBar(
                            backgroundColor: Colors.grey[800],
                            floating: true,
                            toolbarHeight: 0,
                            expandedHeight: 280,
                            flexibleSpace: FlexibleSpaceBar(
                                background: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                  child: headerSilverAppBar(maxline: maxLine)),
                            ))),
                      ];
                    },
                    body: Column(
                      children: <Widget>[
                        Material(
                          color: Colors.grey[800],
                          child: TabBar(
                            controller: primaryTC,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(text: "CONTENTS"),
                              Tab(text: "TRANSCRIPT"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: primaryTC,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Column(
                                  children: makeListContent(),
                                ),
                              ),
                              Text('This is tab oe'),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  Widget makeItemButton({Widget icon, String title}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('Click');
        },
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

  Widget headerSilverAppBar({bool maxline}) {
    return Container(
      color: Colors.grey[800],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Architecting for Reliablity on AWS',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Chip(
            padding: EdgeInsets.zero,
            avatar: ClipOval(
              child: Container(
                color: Colors.orange,
              ),
            ),
            label: Text('Mike Pfeiffer'),
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
                rating: 3.45,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 15.0,
                direction: Axis.horizontal,
              ),
              Text(
                '(555)',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              makeItemButton(
                  icon: Icon(Icons.bookmark_outline), title: 'Bookmarked'),
              makeItemButton(
                  icon: Icon(Icons.playlist_add), title: 'Add to Channel'),
              makeItemButton(
                  icon: Icon(Icons.arrow_circle_down), title: 'Dowload'),
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
                      'Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.'
                      'Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.',
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
                      color: Colors.grey,
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

  List<Column> makeListContent() {
    return list
        .map((item) => Column(
              children: [
                ListTile(
                  title: Text(
                    item.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    item.time.toString(),
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
                        return <PopupMenuEntry<FlatButton>>[
                          PopupMenuItem(
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Bookmark',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          PopupMenuItem(
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Add to channel',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          PopupMenuItem(
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Remove Download',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ];
                      }),
                ),
                Column(
                  children: item.list
                      .map((it) => ListTile(
                            //leading:
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
                                  it.title,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            trailing: Text(
                              it.time.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                )
              ],
            ))
        .toList();
  }
}

class Content {
  String title;
  int time;
  Content({this.time, this.title});
}

class SubContent extends Content {
  List<Content> list;
  SubContent({this.list, String title, int time})
      : super(time: time, title: title);
}
