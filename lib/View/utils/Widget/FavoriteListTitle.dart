import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/DownloadModel.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/utils/page/CourseDetail.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavoriteListTitle extends StatelessWidget {
  final CourseInfor course;
  final int indexChannel;

  const FavoriteListTitle({Key key, this.course, this.indexChannel = -1})
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
                image: (course.imageUrl!=null)? NetworkImage(course.imageUrl):AssetImage('assets/images/DownloadPage/category1.jpg'), fit: BoxFit.cover),
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
              "${course.instructorUserName!=null?course.instructorUserName:course.status.toLowerCase()}",
              style: TextStyle(color: Colors.grey),
              maxLines: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 course.price == 0
                     ? Text(S.current.Free,
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 15,
                             fontWeight: FontWeight.bold))
                     : Text(NumberFormat.currency(locale: "vi")
                         .format(course.price==null?0:course.price), style: TextStyle(
                             color: Colors.white,
                             fontSize: 15,
                             fontWeight: FontWeight.bold))
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
                              ? S.current.Unlike
                              : S.current.Like,
                        )),
                    PopupMenuItem(
                        value: 1,
                        child: Consumer<DownloadModel>(
                          builder: (context, provider, _) {
                            return Text(
                                //isDownload ? 'Remove Download' : 'Download',
                                S.current.Download);
                          },
                        )),
                    indexChannel >= 0
                        ? PopupMenuItem(
                            value: 2,
                            child: Text(
                              S.current.Remove,
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
