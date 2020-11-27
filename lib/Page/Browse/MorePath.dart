import 'package:Pluralsight/Components/PathListTitle.dart';
import 'package:Pluralsight/models/MyChannel.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MorePath extends StatelessWidget {
  final String title;

  const MorePath({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<MyChannelModel> listChannel = context.watch<MyChannelListModel>().listChannel;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            itemCount: listChannel.length,
            itemBuilder: (context, index) {
              return PathListTile(channel: listChannel[index],);
            }),
      ),
    );
  }
}
