import 'package:Pluralsight/Components/AuthorListTitle.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:flutter/material.dart';

class AuthourPage extends StatelessWidget {
  final List<AuthorModel> authors;

  const AuthourPage({Key key, this.authors}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${authors.length} Results',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
            child: ListView.builder(
                itemCount: authors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: authorListTitle(context,authors[index]),
                  );
                })),
      ],
    );
  }
}
