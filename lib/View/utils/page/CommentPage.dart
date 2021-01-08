import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Response/ResGetDetailCourseNonUser.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/CourseService.dart';
import 'package:Pluralsight/View/utils/page/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final List<RatingList> rating;
  final String courseId;

  const CommentPage({Key key, @required this.rating, @required this.courseId})
      : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  double contentPoint, formalityPoint, presentationPoint;
  TextEditingController contentController;
  @override
  void initState() {
    contentPoint =
        formalityPoint = presentationPoint = ConstantPage.INITIALRATING;
    contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountInf accountInf = Provider.of(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: accountInf.isAuthorization()
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "Create Comment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            makeRowRating(
                                content: "Content Point",
                                callback: (value) {
                                  contentPoint = value;
                                  print(contentPoint);
                                }),
                            makeRowRating(
                                content: "Formality Point",
                                callback: (value) {
                                  formalityPoint = value;
                                  print(formalityPoint);
                                }),
                            makeRowRating(
                                content: "Presentation Point",
                                callback: (value) {
                                  presentationPoint = value;
                                  print(presentationPoint);
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                controller: contentController,
                                decoration: new InputDecoration(
                                    hintText: "Comment ....",
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ))),
                            RaisedButton(
                              onPressed: () async {
                                if (contentController.text.trim().isEmpty) {
                                  Toast.show(
                                      context: context,
                                      content: "Chưa nhập nội dung");
                                  return;
                                }
                                print(
                                    '$contentPoint $presentationPoint $formalityPoint ${contentController.text}');
                                Response res = await CourseService.postCommnent(
                                    courseID: widget.courseId,
                                    token: accountInf.token,
                                    content: contentController.text.trim(),
                                    contentPoint: contentPoint,
                                    formalityPoint: formalityPoint,
                                    presentationPoint: presentationPoint);
                                print(res.body);
                                if (res.statusCode == 200) {
                                  Toast.show(
                                      context: context,
                                      content: "Successfully");
                                } else if(res.statusCode == 400){
                                  Toast.show(
                                      context: context,
                                      content: "Bạn chưa tham gia khóa học !");
                                }
                                else {
                                  Toast.show(
                                      context: context,
                                      content: jsonDecode(res.body)["message"]);
                                }
                              },
                              child: Text("Post"),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.rating[index].user.name}"),
                        //SizedBox(width: 20,),
                        Text(
                          "${Format.getInstantDateFormat().format(widget.rating[index].createdAt)}",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.rating[index].content}"),
                        RatingBarIndicator(
                          rating: widget.rating[index].averagePoint * 1.0,
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
                                    image: NetworkImage(
                                        widget.rating[index].user.avatar))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: widget.rating.length))
          ],
        ));
  }
}

makeRowRating({@required String content, @required Function(double) callback}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(content),
      RatingBar(
        itemSize: 20,
        initialRating: ConstantPage.INITIALRATING,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          full: Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          half: Icon(
            Icons.star_half,
            color: Colors.yellow,
          ),
          empty: Icon(
            Icons.star_border,
          ),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        onRatingUpdate: callback,
      )
    ],
  );
}
