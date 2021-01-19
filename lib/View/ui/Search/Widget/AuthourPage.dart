import 'package:Pluralsight/Core/models/Response/ResSearchV2.dart';
import 'package:Pluralsight/View/utils/Widget/AuthorListTitle.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

class AuthourPage extends StatelessWidget {
  final List<InstructorSearchV2> authors;

  const AuthourPage({Key key, this.authors}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${authors.length} ${S.current.Results}',
            style: Theme.of(context).textTheme.subtitle2,
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
