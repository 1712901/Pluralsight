import 'package:Pluralsight/Page/Browse/MorePath.dart';
import 'package:Pluralsight/Page/Home/MyChannelDetail.dart';
import 'package:Pluralsight/Page/PathDetail.dart';
import 'package:Pluralsight/models/FavoriteCourses.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowPathView extends StatelessWidget {
  final String title;

  const RowPathView({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MorePath(
                              title: 'Channels',
                            )));
              },
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
            child: Consumer<FavoriteCourses>(builder: (context, provider, _) {
              if (provider.favoriteCourses == null) {
                return Container();
              }
              int length = provider.favoriteCourses.length;
              return ListView.builder(
                  itemCount: length > 4 ? 4 : length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyChanelDetail(
                        //             channel: provider.listChannel[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AspectRatio(
                          aspectRatio: 2 / 1.5,
                          child: Container(
                            color: Colors.grey[800],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(provider
                                                .favoriteCourses[index]
                                                .courseImage))),
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
                                  child: Center(
                                    child: Text(
                                      provider
                                          .favoriteCourses[index].courseTitle,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            })),
      ],
    );
  }
}
