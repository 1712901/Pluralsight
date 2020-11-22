import 'package:Pluralsight/Components/AppBar.dart';
import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';

class DownLoadsPage extends StatefulWidget {
  @override
  _DownLoadsPageState createState() => _DownLoadsPageState();
}

class _DownLoadsPageState extends State<DownLoadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: myAppbar(title: "Downloads"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '7 courses (300 MB)',
                    style: TextStyle(color: Colors.white),
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'REMOVE ALL',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CourseListTitle();
                    })),
          ],
        ),
      ),
    );
  }
}
