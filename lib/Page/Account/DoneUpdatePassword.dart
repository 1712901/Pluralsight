import 'package:Pluralsight/Page/Account/SignIn.dart';
import 'package:Pluralsight/main.dart';
import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'PASSWORD\nUPDATE',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.check_circle,
              size: 70,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Your password has been uppdate',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 35,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
              },
              child: Text('HOME'),
              color: Colors.blue[400],
            )
          ],
        ),
      ),
    );
  }
}
