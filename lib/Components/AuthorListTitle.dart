import 'package:flutter/material.dart';

Widget authorListTitle() {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey,))
    ),
    child: ListTile(
        onTap: (){},
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        title: Text('Dan Bunker',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,),maxLines: 2,),
        subtitle: Text('8 courses',style: TextStyle(color: Colors.grey),),
        leading: ClipOval(
          child: AspectRatio(
            aspectRatio: 1/1,
            child: Container(
              color: Colors.orange,
            ),
          ),
        ),
    ),
  );
}
