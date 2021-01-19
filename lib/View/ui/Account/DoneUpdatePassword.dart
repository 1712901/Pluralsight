import 'package:Pluralsight/generated/l10n.dart';
import 'package:Pluralsight/main.dart';
import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              S.current.PasswordUpdate,
              style: Theme.of(context).textTheme.headline4,
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
              S.current.UpdatePassSuccess,
              style: Theme.of(context).textTheme.subtitle1,
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
              child: Text(S.current.Home,style: Theme.of(context).textTheme.bodyText1,),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
