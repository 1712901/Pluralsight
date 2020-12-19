import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/FavoriteCourses.dart';
import 'package:Pluralsight/models/Format.dart';
import 'package:Pluralsight/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CourseListTitle extends StatelessWidget {
  final CourseInfor course;
  final int indexChannel;

  const CourseListTitle({Key key, this.course, this.indexChannel = -1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool islogin =
        Provider.of<AccountInf>(context, listen: false).isAuthorization();
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
          decoration: BoxDecoration(
            color: Colors.grey[800],
            image: DecorationImage(
                image: NetworkImage(course.imageUrl), fit: BoxFit.cover),
          ),
          child: Consumer<FavoriteCourses>(
            builder: (context, provider, _) => Align(
              alignment: Alignment.topLeft,
              child: provider.isFavorite(courseId: course.id) && islogin
                  ? Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 15,
                    )
                  : Container(),
            ),
          ),
        ),
        title: Text(
          course.title,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${course.instructorUserName}",
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Format.getInstantDateFormat().format(course.updatedAt),
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
                Text(
                  Format.printDuration(course.totalHours),
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: course.ratedNumber * 1.0,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    //size: 15,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  direction: Axis.horizontal,
                ),
              ],
            )
          ],
        ),
        isThreeLine: true,
        trailing: Consumer<FavoriteCourses>(
          builder: (context, provider, _) {
            //bool isDownload = provider.containsCourse(course.ID);
            return PopupMenuButton(
                offset: Offset(0, 35),
                captureInheritedThemes: false,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (value) async {
                  switch (value) {
                    case 0:
                      String token =
                          Provider.of<AccountInf>(context, listen: false).token;
                      if (token != null) {
                        Response res = await UserService.likeCourse(
                            token: token, courseId: course.id);
                        if (res.statusCode == 200) {
                          provider.likeCourse(courseInfor: course);
                        } else if (res.statusCode == 401) {
                          Provider.of<AccountInf>(context, listen: false)
                              .logout();
                          print('Chưa Đăng Nhập');
                        }
                      } else {
                        print('Chưa Đăng Nhập');
                      }
                      break;
                    case 1:
                      //HandleAdd2Channel.openDialog(context, course.ID);
                      break;
                    case 2:
                      // if (isLogin) {
                      //   // Đã login
                      //   if (!isDownload) {
                      //     //Chưa download
                      //     provider.downloadCourse(course);
                      //     HandleAdd2Channel.showToast(context, "Downloading");
                      //   } else if (isDownload) {
                      //     //Remove download
                      //     provider.removeCourse(course);
                      //     HandleAdd2Channel.showToast(context, "Deleted");
                      //   }
                      // } else {
                      //   HandleAdd2Channel.showToast(context, "Delete Failed");
                      // }
                      break;
                    case 3:
                      // Provider.of<MyChannelListModel>(context, listen: false)
                      //     .removeCourseInChannel(indexChannel, course.ID);
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
                          provider.isFavorite(courseId: course.id)
                              ? 'Un like'
                              : 'Like',
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: Consumer<DownloadModel>(
                          builder: (context, provider, _) {
                            return Text(
                                //isDownload ? 'Remove Download' : 'Download',
                                "Download");
                          },
                        )),
                    indexChannel >= 0
                        ? PopupMenuItem(
                            value: 2,
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
}
