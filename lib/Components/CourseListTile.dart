import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget courseListTile() {
  return ListTile(
    onTap: () {},
    leading: Container(
      width: 75,
      height: 75,
      color: Colors.orange,
    ),
    title: Text(
      'Domain-Driven Design in Practice',
      style: TextStyle(color: Colors.white),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vladimir Khorikov',
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          'Intermediate Feb_2019 9h35m',
          style: TextStyle(color: Colors.grey),
          overflow: TextOverflow.visible,
          maxLines: 1,
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: 3.45,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                //size: 15,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 15.0,
              direction: Axis.horizontal,
            ),
            Text(
              '(555)',
              style: TextStyle(color: Colors.grey),
            )
          ],
        )
      ],
    ),
    isThreeLine: true,
    trailing: PopupMenuButton(
        offset: Offset(0, 35),
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        color: Colors.grey[800],
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<FlatButton>>[
            PopupMenuItem(
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Bookmark',
                      style: TextStyle(color: Colors.white),
                    ))),
            PopupMenuItem(
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Add to channel',
                      style: TextStyle(color: Colors.white),
                    ))),
            PopupMenuItem(
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Remove Download',
                      style: TextStyle(color: Colors.white),
                    ))),
          ];
        }),
  );
}
