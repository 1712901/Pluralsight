import 'package:Pluralsight/Components/RowPathView.dart';
import 'package:flutter/material.dart';

class PathsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Paths'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,top: 10.0),
          child: Column(
            children: [
              RowPathView(title: 'Conferences',),
              RowPathView(title: 'Certifications',),
              RowPathView(title: 'Software Development',),
              RowPathView(title: 'IT Ops',),
              RowPathView(title: 'Information Security',),
            ],
          ),
        ),
      ),
    );
  }
}