import 'package:flutter/material.dart';

Widget myAppbar({title}) {
  return AppBar(
    title: Text(title),
    actions: [
      InkWell(
        onTap: () {
          print('avatar');
        },
        child: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.only(top: 15, bottom: 15),
          //padding: EdgeInsets.all(15),
          //margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(15),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/avaImage.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
      IconButton(icon: Icon(Icons.more_vert), onPressed: null),
    ],
  );
}
