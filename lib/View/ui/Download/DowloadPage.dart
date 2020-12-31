import 'package:Pluralsight/Core/models/DownloadModel.dart';
import 'package:Pluralsight/View/utils/Widget/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownLoadsPage extends StatefulWidget {
  @override
  _DownLoadsPageState createState() => _DownLoadsPageState();
}

class _DownLoadsPageState extends State<DownLoadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: myAppbar(title: "Downloads",context: context),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<DownloadModel>(builder: (context, provider, _) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${provider.courses.length} courses (${provider.size} MB)',
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                          onPressed: () {
                            Provider.of<DownloadModel>(context,listen: false).removeAll();
                          },
                          child: Text(
                            'REMOVE ALL',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                // Flexible(
                //     child: ListView.builder(
                //         itemCount: provider.courses.length,
                //         itemBuilder: (context, index) {
                //           return CourseListTitle(
                //             course: provider.courses[index],
                //             indexChannel: -1,
                //           );
                //         })),
              ],
            );
          })),
    );
  }
}
