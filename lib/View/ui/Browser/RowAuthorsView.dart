import 'dart:convert';

import 'package:Pluralsight/Core/models/Response/ResGetIntructor.dart';
import 'package:Pluralsight/Core/service/IntructorService.dart';
import 'package:Pluralsight/View/utils/page/AuthorDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RowAuthorsView extends StatelessWidget {
  final String title;

  const RowAuthorsView({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder(
            future: InstructorService.getInstructor(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Response res = snapshot.data;
                if (res.statusCode == 200) {
                  ResGetIntructor resGetIntructor =
                      ResGetIntructor.fromJson(jsonDecode(res.body));
                  List<Instructor> intructors = resGetIntructor.intructor;
                  return Container(
                    height: 230,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2.2 / 1.5, crossAxisCount: 2),
                      scrollDirection: Axis.horizontal,
                      itemCount: intructors.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthorDetail(
                                        instructorId: resGetIntructor.intructor[index].id,
                                      )));
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  intructors[index].userAvatar),
                                              fit: BoxFit.cover)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                          Colors.black.withOpacity(0.3),
                                          Colors.black.withOpacity(0.3),
                                        ])),
                                      ),
                                    ),
                                ),
                              ),
                            ),
                            Container(
                                child: Text(
                              intructors[index].userName,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  print("error");
                  return Container();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ],
    );
  }
}
