import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/View/utils/Widget/FavoriteListTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MoreFavorite extends StatefulWidget {
  final String title;
  const MoreFavorite({Key key,this.title}) : super(key: key);
  @override
  _MoreFavoriteState createState() => _MoreFavoriteState();
}

class _MoreFavoriteState extends State<MoreFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:  Consumer<FavoriteCourses>(
                  builder:(context,provider,_)=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: provider.favoriteCourses.length > 0
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return FavoriteListTitle(
                                course: provider.favoriteCourses[index].convertToCourseInfor(),
                              );
                            },
                            itemCount: provider.favoriteCourses.length,
                          )
                        : Center(child: new CircularProgressIndicator()),
                  ),
        ));
  }
}
