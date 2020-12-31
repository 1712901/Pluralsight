import 'package:Pluralsight/Core/models/MyChannelList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HandleAdd2Channel{
    static Future<void> openDialog(BuildContext context, int idCourse) async {
    int index = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.grey[800],
            title:
                Text('Add to channel', style: TextStyle(color: Colors.white)),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, -1);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      'New Channel',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Consumer<MyChannelListModel>(
                builder: (context, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: provider.listChannel
                        .map((e) => SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(
                                    context, provider.listChannel.indexOf(e));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    e.name,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  );
                },
              )
            ],
          );
        });
    if (index == -1) {
      creatAlertDialog(context).then((value) {
        if (value != null) {
          if (value.isNotEmpty) {
            Provider.of<MyChannelListModel>(context, listen: false)
                .addMyChannel(value);
            showToast(context, "Created Channel");
          }
        }
      });
    } else if (index != null) {
      //list[index].addCourse(idCourse);
      Provider.of<MyChannelListModel>(context, listen: false)
          .addCourse(index, idCourse);
      showToast(context, "Added Course");
    }
  }

  static Future<String> creatAlertDialog(BuildContext context) {
    TextEditingController editingController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            title: Text('Create channel'),
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

  static void showToast(BuildContext context, String content) {
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