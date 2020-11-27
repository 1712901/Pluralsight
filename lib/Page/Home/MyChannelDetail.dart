import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/models/Course.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/MyChannel.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyChanelDetail extends StatelessWidget {
  final MyChannelModel channel;

  const MyChanelDetail({Key key, this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CourseModel> list =
        Provider.of<CourseListModel>(context, listen: false).couserList;
    //MyChannel myChannel = Provider.of<MyChannel>(context);
    //print(myChannel.name);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Consumer<MyChannelListModel>(
            builder: (_, provider, child) => Text(channel.name)),
        actions: [
          PopupMenuButton(
              onSelected: (index) {
                switch (index) {
                  case 0:
                    print('Share');
                    break;
                  case 1:
                    print('Edit');
                    // Provider.of<MyChannelList>(context, listen: false)
                    //     .editChannel(channel, name);
                    creatAlertDialog(context).then((value) {
                      if (value != null) {
                        if (value.isNotEmpty) {
                          Provider.of<MyChannelListModel>(context,
                                  listen: false)
                              .editChannel(channel, value);
                          _showToast(context, "Edited Channel");
                        }
                      }
                    });
                    break;
                  case 2:
                    print('Delete');
                    Provider.of<MyChannelListModel>(context, listen: false)
                        .removeChannel(channel);
                    break;
                }
              },
              color: Colors.grey[800],
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(value: 0, child: Text('Share')),
                  PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Edit',
                      )),
                  PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Delete',
                      )),
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.2),
                Colors.green.withOpacity(0.3)
              ], begin: Alignment.centerLeft)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<MyChannelListModel>(
                        builder: (_, provider, child) => Text(
                              channel.name,
                              style: TextStyle(fontSize: 25),
                            )),
                    Text(
                      "${channel.listIDCourse.length.toString()} Courses",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: channel.listIDCourse.length,
                  itemBuilder: (context, index) {
                    return Consumer<MyChannelListModel>(
                        builder: (context, provider, _) {
                      return CourseListTitle(
                          course: list.firstWhere((cour) =>
                              cour.ID == channel.listIDCourse[index]));
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<String> creatAlertDialog(BuildContext context) {
    TextEditingController editingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            title: Text('Edit Name'),
            content: TextField(
              controller: editingController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(editingController.text);
                  },
                  child: Text('SAVE',
                      style: TextStyle(color: Theme.of(context).accentColor))),
            ],
          );
        });
  }

  void _showToast(BuildContext context, String content) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${content}'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
