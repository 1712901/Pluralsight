import 'package:Pluralsight/Core/models/Response/ResSearchV2.dart';
import 'package:Pluralsight/View/utils/page/AuthorDetail.dart';
import 'package:Pluralsight/generated/l10n.dart';
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
        style: Theme.of(context).textTheme.subtitle1,
        maxLines: 2,
      ),
      subtitle: Text(
        '${author.numcourses} ${S.current.courses}',
        style: Theme.of(context).textTheme.subtitle2,
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
