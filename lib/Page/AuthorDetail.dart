import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:flutter/material.dart';

class AuthorDetail extends StatefulWidget {
  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  bool maxline = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Author'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                alignment: Alignment.center,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Jon Flanders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'Pluralsight Author',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child:
                          Text('FOLLOW', style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                    ),
                  ),
                  Text('Follow to be notified when new courses are published',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                ],
              ),
              SizedBox(height:10.0),
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
                          maxLines: maxline ? 2 : null,
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
              FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.link),
                label: Text('http://wwww.master'),
                textColor: Colors.white,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Icon(
                        Icons.wifi,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('Courses',style: TextStyle(color: Colors.white),),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return CourseListTitle();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
