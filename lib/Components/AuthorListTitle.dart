import 'package:Pluralsight/Page/AuthorDetail.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:flutter/material.dart';

Widget authorListTitle(BuildContext context,AuthorModel author) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
      color: Colors.grey,
    ))),
    child: ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthorDetail(author: author,)));
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
        '${author.courses.length} courses',
        style: TextStyle(color: Colors.grey),
      ),
      leading: ClipOval(
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            color: Colors.orange,
          ),
        ),
      ),
    ),
  );
}
