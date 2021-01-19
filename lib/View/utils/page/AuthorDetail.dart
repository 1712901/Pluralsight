import 'dart:convert';

import 'package:Pluralsight/Core/models/Response/ResInstructorDeatil.dart';
import 'package:Pluralsight/Core/service/IntructorService.dart';
import 'package:Pluralsight/View/utils/Widget/CourseListTile.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';

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
      appBar: AppBar(
        title: Text(S.current.Instructor,style: Theme.of(context).appBarTheme.textTheme.headline4,),
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
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'Pluralsight Author',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
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
                                    style: Theme.of(context).textTheme.subtitle1,
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
                                    color: Theme.of(context).iconTheme.color,
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
                        Row(
                          children: [
                            Text("${S.current.Major} :",
                                style: Theme.of(context).textTheme.subtitle1),
                            SizedBox(
                              width: 10,
                            ),
                            Text(instructorDetail.major!=null?instructorDetail.major:"",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                        instructorDetail.phone!=null?FlatButton.icon(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.phone,color: Theme.of(context).iconTheme.color,),
                          label: Text(instructorDetail.phone.toString(),style:Theme.of(context).textTheme.subtitle1),
                        ):Container(),
                        FlatButton.icon(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.mail,color: Theme.of(context).iconTheme.color,),
                          label: Text(instructorDetail.email,style: Theme.of(context).textTheme.subtitle1,),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${S.current.courses} (${instructorDetail.courses.length})',
                          style: Theme.of(context).textTheme.headline6,
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
              }else{
                return Container(
                  child: Center(
                    child: Icon(Icons.error_outline,size: 30,),
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
