import 'dart:convert';

import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/Response/ResInstructorDeatil.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:Pluralsight/service/IntructorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AuthorDetail extends StatefulWidget {
  final String instructorId;

  const AuthorDetail({Key key, this.instructorId}) : super(key: key);
  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  bool maxline = true;
  _AuthorDetailState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Instructor'),
      ),
      body: FutureBuilder(
          future: InstructorService.getInstructorDetail(
              intructorId: widget.instructorId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Response res = snapshot.data;
              if (res.statusCode == 200) {
                ResInstructorsDetail resInstructorsDetail =
                    ResInstructorsDetail.fromJson(jsonDecode(res.body));
                InstructorDetail instructorDetail =
                    resInstructorsDetail.instructorDetail;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                        image: NetworkImage(
                                            instructorDetail.avatar))),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Text(
                              instructorDetail.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              'Pluralsight Author',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBarIndicator(
                              rating: instructorDetail.ratedNumber * 1.0,
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
                        SizedBox(height: 20.0),
                        instructorDetail.intro!=null ?IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 15,
                                child: Container(
                                  child: Text(
                                    instructorDetail.intro,
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
                                    print(1);
                                    setState(() {
                                      maxline = (!maxline);
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
                        ):Container(),
                        FlatButton.icon(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.mail),
                          label: Text(instructorDetail.email),
                          textColor: Colors.white,
                        ),
                        Row(
                          children: [
                            Text("Major :",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(instructorDetail.major!=null?instructorDetail.major:""),
                            instructorDetail.phone!=null?Flexible(
                              fit: FlexFit.tight,
                              child: FlatButton.icon(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(Icons.phone),
                                label: Text(instructorDetail.phone),
                                textColor: Colors.white,
                              ),
                            ):Container(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Courses (${instructorDetail.courses.length})',
                          style: TextStyle(color: Colors.white),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: instructorDetail.courses.length,
                            itemBuilder: (context, index) {
                              instructorDetail.courses[index].instructorUserId =
                                  instructorDetail.id;
                              instructorDetail.courses[index]
                                  .instructorUserName = instructorDetail.name;
                              return CourseListTitle(
                                course: instructorDetail.courses[index],
                              );
                            })
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
