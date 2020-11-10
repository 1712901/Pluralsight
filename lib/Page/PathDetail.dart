import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';

class PathDetail extends StatefulWidget {
  final String title;

  const PathDetail({Key key, this.title}) : super(key: key);
  @override
  _PathDetailState createState() => _PathDetailState(title);
}

class _PathDetailState extends State<PathDetail> {
  final String title;
  bool maxline = true;

  _PathDetailState(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          PopupMenuButton(
              color: Colors.grey[800],
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<FlatButton>>[
                  PopupMenuItem(
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Add to channel',
                            style: TextStyle(color: Colors.white),
                          ))),
                  PopupMenuItem(
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Share path',
                            style: TextStyle(color: Colors.white),
                          ))),
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    color: Colors.orange,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Android Development with Kotlin - App',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            '5 courses - 16 hours',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        child: Text(
                          'Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.'
                          'Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.',
                          style: TextStyle(color: Colors.white),
                          maxLines: maxline ? 4 : null,
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            maxline = (!maxline);
                          });
                        },
                        child: Container(
                          height: double.infinity,
                          color: Colors.grey,
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Your progress: 0%',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: 0.4,
                  backgroundColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Text('Getting Started',
                          style: TextStyle(color: Colors.white))),
                  Expanded(
                    flex: 1,
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      value: 0.4,
                      backgroundColor: Colors.grey,
                    ),
                  )
                ],
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CourseListTitle();
                  }),
              SizedBox(
                height: 10,
              ),
              Text('Core Development Skills',
                  style: TextStyle(color: Colors.white)),
              Divider(
                color: Colors.grey,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CourseListTitle();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
