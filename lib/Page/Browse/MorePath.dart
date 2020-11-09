import 'package:Pluralsight/Components/PathListTitle.dart';
import 'package:flutter/material.dart';

class MorePath extends StatelessWidget {
  final String title;

  const MorePath({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          itemCount: 20,
          itemBuilder: (context, index) {
          return pathListTile();
        }),
      ),
    );
  }
}
