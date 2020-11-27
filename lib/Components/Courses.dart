import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/MyChannel.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  final int type;

  const Courses({Key key, this.type}) : super(key: key);
  @override
  _CoursesState createState() => _CoursesState(type: type);
}

class _CoursesState extends State<Courses> {
  List<CourseModel> _list;
  CourseListModel courseList;
  List<MyChannelModel> list;
  List<CourseModel> courseByType;
  final int type;
  _CoursesState({this.type});
  @override
  Widget build(BuildContext context) {
    courseList = Provider.of<CourseListModel>(context, listen: false);
    list = Provider.of<MyChannelListModel>(context, listen: true).listChannel;
    _list = courseList.couserList
        .where((element) => element.category == type)
        .toList();
    courseByType = _list.sublist(0, _list.length >= 4 ? 4 : _list.length);
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: courseByType.length,
          itemBuilder: (context, index) {
            return courseCard(course: courseByType[index]);
          }),
    );
  }

  Widget courseCard({CourseModel course}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 220,
      color: Colors.grey[800],
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CourseDetail()));
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.2)
                          ])),
                      child: Consumer<CourseListModel>(
                        builder: (context, provider, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PopupMenuButton(
                                  offset: Offset(0, 35),
                                  onSelected: (index) {
                                    switch (index) {
                                      case 0:
                                        courseList.setBookmark(
                                            course.ID, !course.bookmark);
                                        break;
                                      case 1:
                                        openDialog(course.ID);
                                        break;
                                      case 2:
                                        if (Provider.of<User>(context,listen: false)
                                            .isAuthorization) {
                                          Provider.of<DownloadModel>(context,
                                                  listen: false)
                                              .downloadCourse(course);
                                          _showToast(context, "Downloading");
                                          break;
                                        }
                                         _showToast(context, "Dowload failed");
                                        break;
                                      default:
                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  color: Colors.grey[800],
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<int>>[
                                      PopupMenuItem(
                                          value: 0,
                                          child: Text(
                                            course.bookmark
                                                ? 'UnBookmark'
                                                : 'Bookmark',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      PopupMenuItem(
                                          value: 1,
                                          child: Text(
                                            'Add to channel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      PopupMenuItem(
                                          value: 2,
                                          child: Text(
                                            'Download',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      PopupMenuItem(
                                          value: 3,
                                          child: Text(
                                            'Share',
                                            textAlign: TextAlign.left,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ];
                                  }),
                              IconButton(
                                  alignment: Alignment.bottomRight,
                                  icon: Icon(
                                    course.bookmark
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    courseList.setBookmark(
                                        course.ID, !course.bookmark);
                                  })
                            ],
                          );
                        },
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          course.author,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          //width: 200,
                          child: Text(
                            'Intermediate - Feb_2019 - 9h35m',
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: course.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                //size: 15,
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openDialog(int idCourse) async {
    int index = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.grey[800],
            title:
                Text('Add to channel', style: TextStyle(color: Colors.white)),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, -1);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      'New Channel',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Consumer<MyChannelListModel>(
                builder: (context, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: provider.listChannel
                        .map((e) => SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(
                                    context, provider.listChannel.indexOf(e));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  );
                },
              )
            ],
          );
        });
    if (index == -1) {
      creatAlertDialog(context).then((value) {
        if (value != null) {
          if (value.isNotEmpty) {
            Provider.of<MyChannelListModel>(context, listen: false)
                .addMyChannel(value);
            _showToast(context, "Created Channel");
          }
        }
      });
    } else if (index != null) {
      list[index].addCourse(idCourse);
      Provider.of<MyChannelListModel>(context, listen: false)
          .addCourse(index, idCourse);
      _showToast(context, "Added Course");
    }
  }

  Future<String> creatAlertDialog(BuildContext context) {
    TextEditingController editingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            title: Text('Create channel'),
            content: TextField(
              controller: editingController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(editingController.text);
                  },
                  child: Text('SAVE',
                      style: TextStyle(color: Theme.of(context).accentColor))),
            ],
          );
        });
  }

  void _showToast(BuildContext context, String content) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${content}'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
