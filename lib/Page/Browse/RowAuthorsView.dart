import 'package:Pluralsight/Page/AuthorDetail.dart';
import 'package:Pluralsight/Page/Search/AuthourPage.dart';
import 'package:flutter/material.dart';

class RowAuthorsView extends StatelessWidget {
  final String title;

  const RowAuthorsView({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        Container(
          height: 150,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthorDetail()));
                  },
                                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 75,
                          child: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.black.withOpacity(0.3),
                                  ])),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 75,
                            child: Text(
                              'Ross Bagurdes',
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
