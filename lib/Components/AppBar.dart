import 'package:flutter/material.dart';

Widget myAppbar({title}) {
  return AppBar(
    backgroundColor: Colors.grey[800],
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
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/avaImage.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
      PopupMenuButton(
        color: Colors.grey[800],
        itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<FlatButton>>[
          PopupMenuItem(child: FlatButton(onPressed: (){}, child: Text('Setting',style: TextStyle(color: Colors.white),))),
          PopupMenuItem(child: FlatButton(onPressed: (){}, child: Text('Send feedBack',style: TextStyle(color: Colors.white),))),
          PopupMenuItem(child: FlatButton(onPressed: (){}, child: Text('Contact support',style: TextStyle(color: Colors.white),))),
        ];
      })
    ],
  );
}
