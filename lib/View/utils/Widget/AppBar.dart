import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/View/ui/Account/SignIn.dart';
import 'package:Pluralsight/View/ui/Account/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget myAppbar({title, BuildContext context}) {
  bool isLogin = Provider.of<AccountInf>(context, listen: true).isAuthorization();
  return AppBar(
    backgroundColor: Colors.grey[800],
    title: Text(title),
    actions: [
      InkWell(
        onTap: () {
          print('avatar');
        },
        child: Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/avaImage.jpg'),
                  fit: BoxFit.cover)),
        ),
      ),
      PopupMenuButton(
        captureInheritedThemes:false,
          color: Colors.grey[800],
          onSelected: (value) {
            switch (value) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                break;
              case 3:
                if (isLogin) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                } else {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(builder: (context) => SignIn()));
                }
                break;
              default:
            }
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem(
                  value: 0,
                  child: Text(
                    'Setting',
                    style: TextStyle(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Send feedBack',
                    style: TextStyle(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Text(
                    'Contact support',
                    style: TextStyle(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Text(
                    isLogin ? 'Profile' : 'Login',
                    style: TextStyle(color: Colors.white),
                  )),
            ];
          })
    ],
  );
}
