import 'package:Pluralsight/Components/AuthorListTitle.dart';
import 'package:flutter/material.dart';

class AuthourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '6 Results',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Flexible(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: authorListTitle(context),
                  );
                })),
      ],
    );
  }
}
