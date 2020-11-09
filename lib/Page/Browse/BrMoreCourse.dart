import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';

class BrMoreCourse extends StatelessWidget {
  final String title;

  const BrMoreCourse({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.grey[800],
              title: Text(title),
              expandedHeight: 200,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset('assets/images/background.jpg',
                      fit: BoxFit.cover)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => CourseListTitle(),
                      childCount: 20)),
            )
          ],
        ),
      ),
    );
  }
}
