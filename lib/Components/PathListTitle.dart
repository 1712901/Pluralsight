import 'package:Pluralsight/Page/PathDetail.dart';
import 'package:flutter/material.dart';

class PathListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
      ))),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PathDetail(
                        title: 'Path Detail',
                      )));
        },
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        title: Text(
          'Spring Framework: Core Spring',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
        ),
        subtitle: Text(
          '8 courses',
          style: TextStyle(color: Colors.grey),
        ),
        leading: Container(
          //height: 75,
          width: 75,
          color: Colors.orange,
        ),
      ),
    );
  }
}

// Widget pathListTile() {
//   return Container(
//     decoration: BoxDecoration(
//       border: Border(bottom: BorderSide(color: Colors.grey,))
//     ),
//     child: ListTile(
//       onTap: (){

//       },
//       contentPadding: EdgeInsets.symmetric(vertical: 0),
//       title: Text('Spring Framework: Core Spring',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,),maxLines: 2,),
//       subtitle: Text('8 courses',style: TextStyle(color: Colors.grey),),
//       leading: Container(
//         //height: 75,
//         width: 75,
//         color: Colors.orange,
//       ),
//     ),
//   );
//}
