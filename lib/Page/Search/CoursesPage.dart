import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton.icon(
              onPressed: () {},
              icon: Text(
                'Skill Levels',
                style: TextStyle(color: Colors.grey),
              ),
              label: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '58 Results',
                  style: TextStyle(color: Colors.grey),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      isDense: true,
                      dropdownColor: Colors.grey[800],
                      value: 1,
                      items: [
                        DropdownMenuItem<int>(
                          child: Text(
                            'Newest',
                            style: TextStyle(color: Colors.grey),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem<int>(
                            child: Text('Rel',
                                style: TextStyle(color: Colors.grey)),
                            value: 2),
                      ],
                      onChanged: (index) {}),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CourseListTitle(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
