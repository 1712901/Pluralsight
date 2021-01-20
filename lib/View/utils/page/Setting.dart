import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/MyProvider/ThemeModeApp.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    bool isLogin=Provider.of<AccountInf>(context,listen: false).isAuthorization();
    bool _mode=Provider.of<ThemeModeApp>(context,listen: false).isDarkModeOn;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Setting,style: Theme.of(context).appBarTheme.textTheme.headline4,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Theme",style: Theme.of(context).textTheme.headline6,),
            ListTile(
              title: const Text('Dart mode'),
              leading: Radio<bool>(
                focusColor: Colors.white,
                value: true,
                groupValue: _mode,
                onChanged: (bool value) {
                  setState(() {
                    _mode=value;
                    Provider.of<ThemeModeApp>(context,listen: false).updateTheme(value);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Light mode"),
              leading: Radio<bool>(
                value: false,
                focusColor: Colors.white,
                groupValue: _mode,
                onChanged: (bool value) {
                  setState(() {
                    _mode=value;
                    Provider.of<ThemeModeApp>(context,listen: false).updateTheme(value);
                  });
                },
              ),
            ),
            Divider(),
            Text("App version",style: Theme.of(context).textTheme.headline6,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("1.4",style: Theme.of(context).textTheme.subtitle1,),
            ),
            Divider(),
            Text("Contact/About us",style: Theme.of(context).textTheme.headline6),
            ListTile(
              leading: Icon(Icons.email,color: Theme.of(context).iconTheme.color,),
              title: Text("Tranvi9x@gmail.com"),
            ),
            isLogin?SizedBox(
              width: double.infinity,
              child: OutlineButton(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  onPressed: () async {
                    final storage = new FlutterSecureStorage();
                    await storage.delete(key: 'token');
                    Provider.of<AccountInf>(context, listen: false)
                        .logout();
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.current.LogOut,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )),
            ):Container()
          ],
        ),
      ),
    );
  }
}
