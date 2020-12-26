import 'dart:convert';
import 'dart:ffi';

import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/FavoriteCourses.dart';
import 'package:Pluralsight/models/Format.dart';
import 'package:Pluralsight/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/models/LoadURL.dart';
import 'package:Pluralsight/models/Response/ResGetDetailCourseNonUser.dart';
import 'package:Pluralsight/models/Response/ResGetTopSell.dart';
import 'package:Pluralsight/service/CourseService.dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:android_intent/android_intent.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extend;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'dart:io' show File, Platform;
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:intent/extra.dart' as android_extra;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

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
  final CourseInfor course;
  bool isLogin;
  bool isLike;
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;
  CourseDetailModel courseDetailModel = null;

  _CourseDetailState(this.course);
  // video_player
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    primaryTC = new TabController(length: 2, vsync: this);
    //this.initializePlayer();
    this.getDetailCourse(courseID: course.id);

    super.initState();
  }

  Future<void> initializePlayer({String url}) async {
    videoPlayerController = VideoPlayerController.network(
      url,
    );
    // videoPlayerController = VideoPlayerController.network(
    //     'https://storage.googleapis.com/itedu-bucket/Courses/49c92ee0-58fe-47a7-b111-8e9e273b0910/promo/0e3dc369-ffca-4541-ba74-391c07eb8a45.mov');
    // final video = File('assets/audio/889bbc08-64e1-4dbc-8865-d40c0d00359a.mov');
    // videoPlayerController=VideoPlayerController.file(video);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      aspectRatio: 16 / 9,
      autoInitialize: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (videoPlayerController != null) videoPlayerController.dispose();
    if (chewieController != null) chewieController.dispose();
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final CourseDetailModel courseDetail =
    //     Provider.of<CourseDetailListModel>(context, listen: false)
    //         .getCourseDetail(5);
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
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Stack(children: [
                              // Consumer<LoadURL>(
                              //   builder: (context, provider, _) {
                              //     return Container(
                              //       child:
                              //           Center(child: Text('URL :${provider.url}')),
                              //     );
                              //   },
                              // ),
                              Center(
                                child: chewieController != null &&
                                        chewieController.videoPlayerController
                                            .value.initialized
                                    ? Chewie(
                                        controller: chewieController,
                                      )
                                    //? VideoPlayer(videoPlayerController)
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 20),
                                          Text('Loading'),
                                        ],
                                      ),
                              ),
                              // FutureBuilder(
                              //   future: _initializeVideoPlayerFuture,
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.done) {
                              //       // If the VideoPlayerController has finished initialization, use
                              //       // the data it provides to limit the aspect ratio of the video.
                              //       return AspectRatio(
                              //         aspectRatio:
                              //             _controller.value.aspectRatio,
                              //         // Use the VideoPlayer widget to display the video.
                              //         child: VideoPlayer(_controller),
                              //       );
                              //     } else {
                              //       // If the VideoPlayerController is still initializing, show a
                              //       // loading spinner.
                              //       return Center(
                              //           child: CircularProgressIndicator());
                              //     }
                              //   },
                              // ),
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
                                      course: course,
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
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: makeListRating(
                                          courseDetailModel.ratings.ratingList),
                                    ),
                                  ),
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
      {bool maxline, CourseDetailModel courseDetail, CourseInfor course}) {
    // final List<AuthorModel> authors =
    //     Provider.of<AuthorsModel>(context, listen: false)
    //         .getAllAuthor(course.ID);
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
      color: Colors.grey[800],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),

          SizedBox(
            height: 5,
          ),
          // Container(
          //   height: 50,
          //   child: ListView.builder(
          //       itemCount: authors.length,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => AuthorDetail(
          //                           author: authors[index],
          //                         )));
          //           },
          //           child: Chip(
          //             padding: EdgeInsets.zero,
          //             avatar: ClipOval(
          //               child: Container(
          //                 color: Colors.orange,
          //               ),
          //             ),
          //             label: Text(authors[index].name),
          //           ),
          //         );
          //       }),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Consumer<CourseListModel>(builder: (context, provider, _) {
              //   return makeItemButton(
              //       icon: Icon(course.bookmark
              //           ? Icons.bookmark
              //           : Icons.bookmark_outline),
              //       title: course.bookmark ? 'Bookmarked' : 'Bookmark',
              //       opTap: () {
              //         provider.setBookmark(course.ID, !course.bookmark);
              //       });
              // }),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: course.price == 0
                        ? Text("Miễn Phí",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                        : Text(
                            NumberFormat.currency(locale: "vi")
                                .format(course.price),
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
                      title: isLike && isLogin ? 'Unlike' : "Like",
                      opTap: () async {
                        if (!isLogin) {
                          HandleAdd2Channel.showToast(
                              context, "Chưa đăng nhập");
                        } else {
                          String token =
                              Provider.of<AccountInf>(context, listen: false)
                                  .token;
                          if (token != null) {
                            Response res = await UserService.likeCourse(
                                token: token, courseId: course.id);
                            if (res.statusCode == 200) {
                              provider.likeCourse(courseInfor: course);
                            } else if (res.statusCode == 401) {
                              Provider.of<AccountInf>(context, listen: false)
                                  .setToken(token: null);
                              print('Chưa Đăng Nhập');
                            }
                          }
                        }
                      })),
              makeItemButton(
                  icon: Icon(Icons.arrow_circle_down),
                  title: 'Download',
                  opTap: () {
                    // print("Download");
                    // if (Provider.of<User>(context, listen: false)
                    //     .isAuthorization) {
                    //   Provider.of<DownloadModel>(context, listen: false)
                    //       .downloadCourse(course);
                    //   HandleAdd2Channel.showToast(context, "Downloading");
                    //   return;
                    // }
                    // HandleAdd2Channel.showToast(context, "Dowload failed");
                  }),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                Format.getInstantDateFormat().format(course.updatedAt),
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${course.totalHours} h",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                width: 20,
              ),
              RatingBarIndicator(
                rating: (course.ratedNumber) * 1.0,
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
          Divider(
            color: Colors.grey,
          ),
          Text(
            "Yêu cầu",
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
              : Text("Không có yêu cầu"),
          Text(
            "Bạn sẽ học được",
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
                      "${course.description}",
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
                            'Remove Download',
                            style: TextStyle(color: Colors.white),
                          )),
                        ];
                      }),
                ),
                Column(
                  children: section.lesson
                      .map((lesson) =>
                          Builder(builder: (BuildContext newContext) {
                            return ListTile(
                              onTap: () {
                                //newContext.read<LoadURL>().setUrl(lesson.);
                              },
                              leading: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 8.0),
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
                              trailing: Text(
                                Format.printDuration(lesson.hours),
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

  Future<void> getDetailCourse({String courseID}) async {
    Response res = await CourseService.getDetailNonUser(courseID: courseID);
    print(res.body);
    if (res.statusCode == 200) {
      ResGetDetailCourseNonUser resGetDetailCourseNonUser =
          ResGetDetailCourseNonUser.fromJson(jsonDecode(res.body));
      courseDetailModel = resGetDetailCourseNonUser.courseDetail;
      initializePlayer(url: courseDetailModel.promoVidUrl);
      setState(() {});
    }

    // _controller = VideoPlayerController.network(
    //   courseDetailModel.promoVidUrl,
    // );
    // print(courseDetailModel.promoVidUrl);
    // _initializeVideoPlayerFuture = _controller.initialize();
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
}
