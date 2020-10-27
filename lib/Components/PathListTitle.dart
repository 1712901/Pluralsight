import 'package:flutter/material.dart';

Widget pathListTile() {
  return Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey,))
    ),
    child: ListTile(
      onTap: (){
        
      },
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      title: Text('Spring Framework: Core Spring',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,),maxLines: 2,),
      subtitle: Text('8 courses',style: TextStyle(color: Colors.grey),),
      leading: Container(
        //height: 75,
        width: 75,
        color: Colors.orange,
      ),
    ),
  );
}
