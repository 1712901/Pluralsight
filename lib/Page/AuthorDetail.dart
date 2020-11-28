import 'package:Pluralsight/Components/CourseListTile.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDetail extends StatefulWidget {
  final AuthorModel author;

  const AuthorDetail({Key key, this.author}) : super(key: key);
  @override
  _AuthorDetailState createState() => _AuthorDetailState(author);
}

class _AuthorDetailState extends State<AuthorDetail> {
  bool maxline = true;
  final AuthorModel author;

  _AuthorDetailState(this.author);
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
                    author.name,
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
                    child: Consumer<User>(
                      builder: (context, provider, _) {
                        bool isFollow = provider.isFollow(author.id);
                        return RaisedButton(
                          onPressed: () {
                            if (isFollow) {
                              // Đã follow
                              provider.removeFollow(author.id);
                            } else {
                              //Chưa Follow
                              provider.addFollow(author.id);
                            }
                          },
                          child: Text('${isFollow ? 'FOLLOWING' : 'FOLLOW'}',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        );
                      },
                    ),
                  ),
                  Text('Follow to be notified when new courses are published',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                ],
              ),
              SizedBox(height: 10.0),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        child: Text(
                          author.description,
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
                label: Text(author.link),
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Courses',
                style: TextStyle(color: Colors.white),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: author.courses.length,
                  itemBuilder: (context, index) {
                    return CourseListTitle(
                      course: Provider.of<CourseListModel>(context)
                          .couserList
                          .firstWhere(
                              (element) => author.courses[index] == element.ID),
                      indexChannel: -1,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
