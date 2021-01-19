import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/Core/models/Response/ResGetProfile.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/ui/Account/ResetPasword.dart';
import 'package:Pluralsight/View/ui/Account/UpdatePassword.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'SignIn.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userNameController;
  TextEditingController phoneNumberController;
  TextEditingController emailController;
  TextEditingController newEmailController;
  bool isEdit = false;
  bool isEditEmail = false;
  UserInfo userInfo;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    newEmailController = TextEditingController();
    //getData();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile',style:Theme.of(context).appBarTheme.textTheme.headline4),
        actions: [
          IconButton(
              icon: Icon(isEdit ? Icons.check : Icons.edit),
              onPressed: () async {
                if (isEdit) {
                  Response res = await UserService.updateProfile(
                      phone: phoneNumberController.text,
                      name: userNameController.text,
                      token: Provider.of<AccountInf>(context, listen: false)
                          .token);
                  if (res.statusCode == 200) {
                    Provider.of<AccountInf>(context, listen: false)
                        .setUserInfor(userInfo);
                  } else if (res.statusCode == 400) {
                    HandleAdd2Channel.showToast(
                        context, jsonDecode(res.body)["message"]);
                    return;
                  }
                }
                setState(() {
                  isEdit = !isEdit;
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: UserService.getProfile(
                token: Provider.of<AccountInf>(context, listen: false).token),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('Loading'),
                );
              } else {
                if (snapshot.hasError) {
                  print("Error");
                }
                Response response = snapshot.data;
                if (response.statusCode == 401) {
                  return Container(
                    child: Center(
                      child: SizedBox(
                          width: double.infinity,
                          child: Builder(
                            builder: (newContext) => RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                S.current.SignIn,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          )),
                    ),
                  );
                } else {
                  UserInfo userInfo =
                      ResGetProfile.fromJson(jsonDecode(snapshot.data.body))
                          .userInfo;
                  Provider.of<AccountInf>(context, listen: false)
                      .setUserInfor(userInfo);
                  userNameController.text = userInfo.name;
                  emailController.text = userInfo.email;
                  phoneNumberController.text = userInfo.phone;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(userInfo.avatar),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: isEdit,
                        controller: userNameController,
                        style: Theme.of(context).textTheme.subtitle1,
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: S.current.Name,
                            labelStyle: Theme.of(context).textTheme.subtitle2),
                      ),
                      TextField(
                        enabled: isEdit,
                        controller: phoneNumberController,
                        style: Theme.of(context).textTheme.subtitle1,
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: S.current.Phone,
                            labelStyle: Theme.of(context).textTheme.subtitle2),
                      ),
                      TextField(
                        enabled: isEditEmail,
                        style: Theme.of(context).textTheme.subtitle1,
                        controller: emailController,
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Email',
                            labelStyle: Theme.of(context).textTheme.subtitle2),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  bool action = await showDialog(
                                      context: context,
                                      builder: (contextDialog) {
                                        return AlertDialog(
                                          backgroundColor: Theme.of(contextDialog).backgroundColor,
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          title: Text('New Email'),
                                          content: TextField(
                                            controller: newEmailController,
                                            maxLines: 1,
                                            maxLength: 20,
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                            ),

                                          ),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  newEmailController.dispose();
                                                  Navigator.pop(
                                                      contextDialog, false);
                                                },
                                                child: Text(
                                                  'CANCEL',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                )),
                                            FlatButton(
                                                onPressed: () async {
                                                  Navigator.pop(
                                                      contextDialog, true);
                                                },
                                                child: Text('SAVE',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor))),
                                          ],
                                        );
                                      });
                                  if (action == true) {
                                    Response res =
                                        await UserService.changeEmail(
                                            newEmail: newEmailController.text,
                                            token: Provider.of<AccountInf>(
                                                    context,
                                                    listen: false)
                                                .token);
                                    if (res.statusCode == 200) {
                                      HandleAdd2Channel.showToast(context,
                                          S.current.CheckEmail);
                                      final storage =
                                          new FlutterSecureStorage();
                                      await storage.delete(key: 'token');
                                      Provider.of<AccountInf>(context,
                                              listen: false)
                                          .logout();
                                    } else if (res.statusCode == 400) {
                                      HandleAdd2Channel.showToast(
                                          context, S.current.EmailAlreadyExists);
                                    }
                                  }
                                },
                                child: Text(
                                  S.current.ChangeEmail,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePassword()));
                                },
                                child: Text(
                                  S.current.ChangePassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => ResetPassword()));
                            },
                            child: Text(
                              S.current.ResetPassword,
                              style: TextStyle(color: Theme.of(context).accentColor),
                            )),
                      ),
                      SizedBox(
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
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
