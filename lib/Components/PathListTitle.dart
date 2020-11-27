import 'package:Pluralsight/Page/Home/MyChannelDetail.dart';
import 'package:Pluralsight/Page/PathDetail.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/MyChannel.dart';
import 'package:flutter/material.dart';

class PathListTile extends StatelessWidget {
  final MyChannelModel channel;

  const PathListTile({Key key, this.channel}) : super(key: key);
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
                  builder: (context) => MyChanelDetail(
                        channel: channel,
                      )));
        },
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        title: Text(
          channel.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
        ),
        subtitle: Text(
          '${channel.listIDCourse.length} courses',
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
