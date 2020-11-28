import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class CourseListTitle extends StatelessWidget {
  final CourseModel course;
  final int indexChannel;

  const CourseListTitle({Key key, this.course, this.indexChannel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLogin = Provider.of<User>(context, listen: false).isAuthorization;
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey[600],
        )),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseDetail(
                        course: course,
                      )));
        },
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Container(
          width: 75,
          height: 75,
          color: Colors.orange,
        ),
        title: Text(
          course.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.author,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              'Intermediate Feb_2019 9h35m',
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.visible,
              maxLines: 1,
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
        isThreeLine: true,
        trailing: Consumer<DownloadModel>(
          builder: (context, provider, _) {
            bool isDownload = provider.containsCourse(course.ID);

            return PopupMenuButton(
                offset: Offset(0, 35),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      Provider.of<CourseListModel>(context, listen: false)
                          .setBookmark(course.ID, !course.bookmark);
                      break;
                    case 1:
                      HandleAdd2Channel.openDialog(context, course.ID);
                      break;
                    case 2:
                      if (isLogin) {
                        // Đã login
                        if (!isDownload) {
                          //Chưa download
                          provider.downloadCourse(course);
                          HandleAdd2Channel.showToast(context, "Downloading");
                        } else if (isDownload) {
                          //Remove download
                          provider.removeCourse(course);
                          HandleAdd2Channel.showToast(context, "Deleted");
                        }
                      } else {
                        HandleAdd2Channel.showToast(context, "Delete Failed");
                      }
                      break;
                    case 3:
                      Provider.of<MyChannelListModel>(context, listen: false)
                          .removeCourseInChannel(indexChannel, course.ID);
                      break;
                    default:
                  }
                },
                color: Colors.grey[800],
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        value: 0,
                        child: Text(
                          course.bookmark ? 'Unbookmark' : 'Bookmark',
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Add to channel',
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Consumer<DownloadModel>(
                          builder: (context, provider, _) {
                            return Text(
                              isDownload ? 'Remove Download' : 'Download',
                            );
                          },
                        )),
                    indexChannel >= 0
                        ? PopupMenuItem(
                            value: 3,
                            child: Text(
                              'Remove',
                            ))
                        : PopupMenuItem(
                            child: Container(),
                            height: 0,
                          ),
                  ];
                });
          },
        ),
      ),
    );
  }

  // Future<void> openDialog(BuildContext context, int idCourse) async {
  //   int index = await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           backgroundColor: Colors.grey[800],
  //           title:
  //               Text('Add to channel', style: TextStyle(color: Colors.white)),
  //           children: [
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.pop(context, -1);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.add,
  //                     color: Colors.white,
  //                   ),
  //                   Text(
  //                     'New Channel',
  //                     style: TextStyle(color: Colors.white),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Consumer<MyChannelListModel>(
  //               builder: (context, provider, _) {
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.stretch,
  //                   children: provider.listChannel
  //                       .map((e) => SimpleDialogOption(
  //                             onPressed: () {
  //                               Navigator.pop(
  //                                   context, provider.listChannel.indexOf(e));
  //                             },
  //                             child: Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.check,
  //                                   color: Colors.white,
  //                                 ),
  //                                 Text(
  //                                   e.name,
  //                                   style: TextStyle(color: Colors.white),
  //                                 )
  //                               ],
  //                             ),
  //                           ))
  //                       .toList(),
  //                 );
  //               },
  //             )
  //           ],
  //         );
  //       });
  //   if (index == -1) {
  //     creatAlertDialog(context).then((value) {
  //       if (value != null) {
  //         if (value.isNotEmpty) {
  //           Provider.of<MyChannelListModel>(context, listen: false)
  //               .addMyChannel(value);
  //           _showToast(context, "Created Channel");
  //         }
  //       }
  //     });
  //   } else if (index != null) {
  //     //list[index].addCourse(idCourse);
  //     Provider.of<MyChannelListModel>(context, listen: false)
  //         .addCourse(index, idCourse);
  //     _showToast(context, "Added Course");
  //   }
  // }

  // Future<String> creatAlertDialog(BuildContext context) {
  //   TextEditingController editingController = new TextEditingController();
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //           title: Text('Create channel'),
  //           content: TextField(
  //             controller: editingController,
  //             maxLines: 1,
  //             maxLength: 20,
  //             decoration: InputDecoration(
  //               hintText: 'Name',
  //             ),
  //           ),
  //           actions: [
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   'CANCEL',
  //                   style: TextStyle(color: Theme.of(context).accentColor),
  //                 )),
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(editingController.text);
  //                 },
  //                 child: Text('SAVE',
  //                     style: TextStyle(color: Theme.of(context).accentColor))),
  //           ],
  //         );
  //       });
  // }

  // void _showToast(BuildContext context, String content) {
  //   final scaffold = Scaffold.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: Text('${content}'),
  //       action: SnackBarAction(
  //           label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }
}
