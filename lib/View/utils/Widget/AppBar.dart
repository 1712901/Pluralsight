import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/SearchBuilder/SearchOption.dart';
import 'package:Pluralsight/View/ui/Account/SignIn.dart';
import 'package:Pluralsight/View/ui/Account/Profile.dart';
import 'package:Pluralsight/View/utils/page/Setting.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget myAppbar({title, BuildContext context}) {
  bool isLogin =
      Provider.of<AccountInf>(context, listen: true).isAuthorization();
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).appBarTheme.textTheme.headline4,
    ),
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
          captureInheritedThemes: false,
          color: Theme.of(context).backgroundColor,
          onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
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
                    S.current.Setting,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
              PopupMenuItem(
                  value: 1,
                  child: Text(
                    S.current.SendFeedBack,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Text(
                    S.current.ContactSupport,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Text(
                    isLogin ? S.current.Profile : S.current.Login,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
            ];
          })
    ],
  );
}
