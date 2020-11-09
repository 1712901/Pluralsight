import 'package:flutter/material.dart';

class RowPathView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Path',
              style: TextStyle(color: Colors.white),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Text(
                'See all',
              ),
              label: Icon(Icons.navigate_next),
              textColor: Colors.grey,
            )
          ],
        ),
        Container(
          height: 150,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AspectRatio(
                    aspectRatio: 2 / 1.5,
                    child: Container(
                      color: Colors.grey[800],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.3),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text(
                                'Pluralsight live 2020',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '95 courses',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
