import 'package:Pluralsight/Page/Browse/MorePath.dart';
import 'package:Pluralsight/Page/Home/MyChannelDetail.dart';
import 'package:Pluralsight/Page/PathDetail.dart';
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
            child: Consumer<MyChannelListModel>(builder: (context, provider, _) {
              return ListView.builder(
                  itemCount: provider.listChannel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyChanelDetail(
                                    channel: provider.listChannel[index])));
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
                                      provider.listChannel[index].name
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${provider.listChannel[index].listIDCourse.length} courses',
                                      style: TextStyle(color: Colors.white),
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
