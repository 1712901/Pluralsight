import 'package:Pluralsight/Page/AuthorDetail.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/Response/ResGetIntructor.dart';
import 'package:Pluralsight/models/Response/ResSearchV2.dart';
import 'package:flutter/material.dart';

Widget authorListTitle(BuildContext context, InstructorSearchV2 author) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
      color: Colors.grey,
    ))),
    child: ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthorDetail(instructorId: author.id,)));
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        author.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 2,
      ),
      subtitle: Text(
        '${author.numcourses} courses',
        style: TextStyle(color: Colors.grey),
      ),
      leading: ClipOval(
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(author.avatar),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    ),
  );
}
