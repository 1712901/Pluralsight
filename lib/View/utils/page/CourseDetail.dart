import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/DownLoad/DioDownload.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:Pluralsight/Core/models/DownLoad/ManagerData.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/Core/models/LoadURL.dart';
import 'package:Pluralsight/Core/models/Response/ResGetDetailCourseNonUser.dart';
import 'package:Pluralsight/Core/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/Core/models/Response/ResGetVideoLesson.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/Core/service/LessonService.dart';
import 'package:Pluralsight/Core/service/Payment.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/utils/Widget/CustomVideoPlayser.dart';
import 'package:Pluralsight/View/utils/Widget/CustomYoutubePlayer.dart';
import 'package:Pluralsight/View/utils/page/CommentPage.dart';
import 'package:Pluralsight/View/utils/page/RelatedCoures.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:Pluralsight/Core/models/MyProvider/DownloadProgress.dart';
import 'package:http/http.dart';

class CourseDetail extends StatefulWidget {
  final CourseInfor course;

  const CourseDetail({Key key, this.course}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState(course);
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  TabController primaryTC;
  bool maxLine = true;
  bool ownerCourse = false;
  final CourseInfor course;
  bool isLogin;
  bool isLike;
  CourseDetailModel courseDetailModel;

  _CourseDetailState(this.course);

  // video_player
  YoutubePlayerController _youtubePlayerController;
  bool isNextYoutube = false;
  bool isNextVideo = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  double percent=0;

  @override
  void initState() {
    primaryTC = new TabController(length: 2, vsync: this);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
    //this.initializePlayer();
    this.getDetailCourse(courseID: course.id);

    super.initState();
  }

  @override
  void dispose() {
    //if (_betterPlayerController != null) _betterPlayerController.dispose();
    if (_youtubePlayerController != null) _youtubePlayerController.dispose();
    super.dispose();
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      //OpenFile.open(obj['filePath']);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DownLoadsPage()));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin = Provider.of<AccountInf>(context, listen: false).isAuthorization();
    isLike =
        Provider.of<FavoriteCourses>(context).isFavorite(courseId: course.id);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black87,
          body: courseDetailModel != null
              ? DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Stack(children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 40,
                                ),
                              ),
                              AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Consumer<LoadURL>(
                                      builder: (context, provider, _) {
                                        if (provider.isYotuber()) {
                                          return CustomYoutuberPlayer(
                                              next: isNextYoutube,
                                              url: provider.url);
                                        } else {
                                          return CustomVideoPlayer(
                                            url: provider.url,
                                            next: isNextVideo,
                                            isLocal: provider.loadLocal,
                                          );
                                        }
                                      })),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          // if (Platform.isAndroid) {
                                          //   final AndroidIntent intent =
                                          //       AndroidIntent(
                                          //     action: 'action_send',
                                          //     //data: Uri.encodeFull('https://flutter.io'),
                                          //     //package: 'com.android.chrome'
                                          //   );
                                          //   intent.launch();
                                          // }
                                        })
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: extend.NestedScrollView(
                            headerSliverBuilder: (c, f) {
                              return [
                                SliverToBoxAdapter(
                                  child: headerSilverAppBar(
                                      maxline: maxLine,
                                      courseDetail: courseDetailModel),
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
                                      Tab(text: "COMMENTS"),
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
                                    children:
                                        makeListContent(courseDetailModel),
                                  ),
                                ),
                                CommentPage(
                                  rating: courseDetailModel.ratings.ratingList,
                                  courseId: courseDetailModel.id,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget makeItemButton({Widget icon, String title, Function opTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: opTap,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                  child: Container(
                    height: 35,
                    width: 35,
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

  Widget headerSilverAppBar({bool maxline, CourseDetailModel courseDetail}) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
      color: Colors.grey[800],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseDetail.title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: courseDetail.price == 0
                        ? Text(S.current.Free,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : Text(
                            NumberFormat.currency(locale: "vi")
                                .format(courseDetailModel.price),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Consumer<FavoriteCourses>(
                  builder: (context, provider, _) => makeItemButton(
                      icon: isLike && isLogin
                          ? Icon(
                              Icons.star,
                              color: Colors.orange,
                            )
                          : Icon(
                              Icons.star_outline,
                            ),
                      title: isLike && isLogin ? S.current.Unlike : S.current.Like,
                      opTap: () async {
                        if (!isLogin) {
                          Toast.show(content: S.current.NotLogin,context: context);
                        } else {
                          String token =
                              Provider.of<AccountInf>(context, listen: false)
                                  .token;
                          if (token != null) {
                            var res = await UserService.likeCourse(
                                token: token, courseId: course.id);
                            if (res.statusCode == 200) {
                              provider.likeCourse(
                                  courseInfor:
                                      courseDetailModel.convertToCourseInfor());
                            } else if (res.statusCode == 401) {
                              Provider.of<AccountInf>(context, listen: false)
                                  .setToken(token: null);
                              print(S.current.NotLogin);
                            }
                          }
                        }
                      })),
              makeItemButton(
                  //icon: Icon(Icons.arrow_circle_down),
                  icon: Consumer<DownLoadProgress>(
                    builder:(context,provider,_)=> CircularPercentIndicator(
                        radius: 30,
                        percent: provider.percent,
                        progressColor: Colors.blue,
                        backgroundColor: Colors.grey[800],
                        center: new Icon(
                          Icons.file_download,
                          size: 15,
                          color: Colors.blue,
                        ),
                    ),
                  ),
                  title: S.current.Download,
                  opTap: () async {
                    AccountInf account =
                        Provider.of<AccountInf>(context, listen: false);
                    if (account.isAuthorization()) {
                      this.downLoad(lessonID: "intro",userID: account.userInfo.id,courseId: courseDetailModel.id,url: courseDetailModel.promoVidUrl);
                    } else {
                      Toast.show(content: S.current.NotLogin,context: context);
                    }
                  }),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                Format.getInstantDateFormat()
                    .format(courseDetailModel.updatedAt),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${courseDetailModel.totalHours} h",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              RatingBarIndicator(
                rating: (courseDetailModel.ratedNumber) * 1.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          isLogin
              ? FutureBuilder(
                  future: CourseService.getProcess(
                      courseId: courseDetailModel.id,
                      token: Provider.of<AccountInf>(context).token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var res = snapshot.data;
                      if (res.statusCode == 200) {
                        int process = (jsonDecode(res.body)["payload"]);
                        if (process == null) process = 0;
                        return Row(
                          children: [
                            Text(
                              S.current.Progress,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(' ( $process% )'),
                            SizedBox(
                              width: 50,
                            ),
                            Flexible(
                                child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              value: process == null
                                  ? 0
                                  : process.toDouble() / 100,
                            )),
                          ],
                        );
                      }
                      return Container();
                    } else {
                      return Container();
                    }
                  })
              : Container(),
          Divider(
            color: Colors.grey,
          ),
          Text(
            S.current.Requirement,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          courseDetailModel.requirement != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Wrap(
                    children: courseDetailModel.requirement
                        .map((requir) => Text("- $requir"))
                        .toList(),
                  ),
                )
              : Text(S.current.NonRequirement),
          Text(
            S.current.Learn,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          courseDetailModel.requirement != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Wrap(
                    children: courseDetailModel.learnWhat
                        .map((lw) => Text("- $lw"))
                        .toList(),
                  ),
                )
              : Container(),
          Divider(
            color: Colors.grey,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    child: Text(
                      "${courseDetailModel.description}",
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
          Wrap(
            children: [],
          ),
          Provider.of<AccountInf>(context, listen: false).isAuthorization()
              ? SizedBox(
                  width: double.infinity,
                  child: FutureBuilder(
                    future: UserService.checkOwnCourse(
                        token: Provider.of<AccountInf>(context, listen: false)
                            .token,
                        courseId: courseDetailModel.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var res = snapshot.data;
                        if (res.statusCode == 200) {
                          ownerCourse = jsonDecode(res.body)["payload"]
                              ["isUserOwnCourse"];
                          return RaisedButton.icon(
                              onPressed: () async {
                                if (!ownerCourse) {
                                  // đăng ký khóa học
                                  AccountInf accountInf =
                                      Provider.of<AccountInf>(context,
                                          listen: false);
                                  var res =
                                      await PaymentService.paymentFreeCourse(
                                          token: accountInf.token,
                                          courseId: courseDetailModel.id);
                                  print(res.body);
                                  if (res.statusCode == 200) {
                                    setState(() {});
                                  } else {}
                                } else {
                                  //Đã đăng ký
                                  print(S.current.Learning);
                                }
                              },
                              icon: Icon(Icons.done_all),
                              color: Colors.blue,
                              label: ownerCourse
                                  ? Text(S.current.Learning)
                                  : courseDetailModel.price == 0
                                      ? Text(S.current.Enroll)
                                      : Text(S.current.Pay));
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  ))
              : SizedBox(
                  width: double.infinity,
                  child: RaisedButton.icon(
                      onPressed: () {
                        Toast.show(context: context, content: S.current.NotLogin);
                      },
                      icon: Icon(Icons.done_all),
                      color: Colors.blue,
                      label: courseDetailModel.price == 0
                          ? Text(S.current.Enroll)
                          : Text(S.current.Pay)),
                ),
          SizedBox(
              width: double.infinity,
              child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RelatedCourse(
                              listCourse: courseDetailModel.coursesLikeCategory,
                            )));
                  },
                  icon: Icon(Icons.view_carousel),
                  label: Text(S.current.RelatedCourse))),
        ],
      ),
    );
  }

  List<Column> makeListContent(CourseDetailModel courseDetail) {
    return courseDetail.section
        .map((section) => Column(
              children: [
                ListTile(
                  title: Text(
                    section.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    Format.printDuration(section.sumHours),
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
                            S.current.Remove,
                            style: TextStyle(color: Colors.white),
                          )),
                        ];
                      }),
                ),
                Column(
                  children: section.lesson
                      .map((lesson) =>
                          Builder(builder: (BuildContext newContext) {
                            String urlLesson;
                            return ListTile(
                                onTap: () async {
                                  if (Provider.of<AccountInf>(context,
                                              listen: false)
                                          .isAuthorization() &&
                                      this.ownerCourse) {
                                    if(urlLesson==null)
                                      urlLesson =
                                        await getUrlLesson(lesson);
                                    if (urlLesson != null) {
                                      this.isNextYoutube = true;
                                      this.isNextVideo = true;

                                      Provider.of<LoadURL>(context,
                                              listen: false)
                                          .setUrl(urlLesson,lessonID: lesson.id,courseId: lesson.courseId,userId: Provider.of<AccountInf>(context,
                                          listen: false).userInfo.id);
                                    }
                                  }
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 8.0),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.grey,
                                    size: 10,
                                  ),
                                ),
                                title: Text(
                                  "Lesson${lesson.numberOrder} : ${lesson.name}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: FlatButton.icon(
                                    onPressed: () async {
                                      if (Provider.of<AccountInf>(context,
                                                  listen: false)
                                              .isAuthorization() &&
                                          this.ownerCourse) {
                                        DioDownload dioDownload =
                                        new DioDownload(
                                            flutterLocalNotificationsPlugin);
                                        //thực hiện down load
                                        if(urlLesson==null)
                                          urlLesson =
                                          await getUrlLesson(lesson);
                                        if(urlLesson!=null) {
                                         this.downLoad(userID: Provider.of<AccountInf>(context,
                                             listen: false).userInfo.id,courseId: courseDetailModel.id,lessonID: lesson.id,url:urlLesson );
                                        }
                                      }
                                    },
                                    icon: Text(
                                      Format.printDuration(lesson.hours),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    label: Icon(Icons.arrow_circle_down)));
                          }))
                      .toList(),
                )
              ],
            ))
        .toList();
  }

  Future<void> getDetailCourse({String courseID}) async {
    AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
    var res;
    if (!accountInf.isAuthorization()) {
      print("No Login");
      res = await CourseService.getDetail(courseID: courseID);
    } else {
      print("Login");
      res = await CourseService.getDetail(
          courseID: courseID, userID: accountInf.userInfo.id);
    }
    if (res.statusCode == 200) {
      ResGetDetailCourseNonUser resGetDetailCourseNonUser =
          ResGetDetailCourseNonUser.fromJson(jsonDecode(res.body));
      courseDetailModel = resGetDetailCourseNonUser.courseDetail;
      if(accountInf.isAuthorization())
      Provider.of<LoadURL>(context, listen: false)
          .setUrl(courseDetailModel.promoVidUrl,courseId: courseDetailModel.id,lessonID: "intro",userId:accountInf.userInfo.id);
      else{
        Provider.of<LoadURL>(context, listen: false)
            .setUrl(courseDetailModel.promoVidUrl);
      }
      //await initializePlayer(url: courseDetailModel.promoVidUrl);
      setState(() {});
    }
  }

  List<Container> makeListRating(List<RatingList> ratingList) {
    return ratingList
        .map((e) => Container(
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey[600],
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text("${e.user.name}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${e.content}"),
                      RatingBarIndicator(
                        rating: e.averagePoint * 1.0,
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
                  ),
                  leading: Container(
                    height: 100,
                    child: ClipOval(
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(e.user.avatar))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  Future<String> getUrlLesson(Lesson lesson) async {
    var res = await LessonService.getURLLesson(
        token: Provider.of<AccountInf>(context, listen: false).token,
        courseID: lesson.courseId,
        lessonId: lesson.id);
    print(res.body);
    if (res.statusCode == 200) {
      ResGetVideoLesson resGetVideoLesson = resGetVideoLessonFromJson(res.body);
      return resGetVideoLesson.videoLesson.videoUrl;
    }
    return null;
  }
  Future<void> downLoad({String userID,String lessonID,String courseId,String url}) async {
    print("Link Download $url");
    if(await isDownloaded(courseID: courseId,userID: userID,lessonID: lessonID)){
      Toast.show(context: context,content: S.current.Downloaded);
      return;
    }
    if(checkUrl(url)) {
      final manager = ManagerData();
      DioDownload dioDownload = new DioDownload(
          flutterLocalNotificationsPlugin);
      String path = await dioDownload.createPath(url: url,nameVideo: lessonID,courseID: courseId);
      print(path);
      if(path==null) {
        Toast.show(content: S.current.CanNotDownload,context:context );
        return;
      }
      Provider.of<DownLoadProgress>(context,listen: false).startDownload(lessonId: lessonID,courseID: courseId,userID: userID);
      dioDownload.download(
          path, url, (received, total) {
          Provider.of<DownLoadProgress>(context,listen: false).inProgress(percent: received/total);
      }).whenComplete(() async {
        // Thực hiện lưu thông tin vào CSDL khi tải thành công
        Provider.of<DownLoadProgress>(context,listen: false).complete();
        final database = await manager.openDatabase();
        manager.insertLessonCourse(
            courseID: courseId,
            lessonID: lessonID,
            userID: userID,
            path: path);
      }).catchError((err) {
        print(err.toString());
      });
    }else{
      Toast.show(content: S.current.NullUrl,context:context );
    }
  }
  bool checkUrl(String url){
    if(url==null){
      return false;
    }
    return true;
  }
  Future<bool> isDownloaded({String courseID,String userID,String lessonID}) async {
    final manager = ManagerData();
    await manager.openDatabase();
    return manager.isLoadedLession(courseID: courseID,userID: userID,lessonID: lessonID);
  }
}

