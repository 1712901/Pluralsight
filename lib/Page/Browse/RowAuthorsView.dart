import 'package:Pluralsight/Page/AuthorDetail.dart';
import 'package:Pluralsight/Page/Search/AuthourPage.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowAuthorsView extends StatelessWidget {
  final String title;

  const RowAuthorsView({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<AuthorModel> authors= Provider.of<AuthorsModel>(context,listen: false).authors;
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
              itemCount: authors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthorDetail(author: authors[index],)));
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
                              authors[index].name,
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
