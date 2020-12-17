import 'dart:convert';

import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/Response/ResGetProfile.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignIn.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userNameController;

  TextEditingController emailController;

  bool isEdit = false;
  UserInfo userInfo;

  @override
  Future<void> initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
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
    // AccountInf accountInf = Provider.of<AccountInf>(context, listen: false);
    // userNameController.text = accountInf.userInfo.name;
    // emailController.text = accountInf.userInfo.email;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
              icon: Icon(isEdit ? Icons.check : Icons.edit),
              onPressed: () {
                if (isEdit) {
                  //Update Proflie
                  // user.setProfile(
                  //     name: userNameController.text,
                  //     email: emailController.text);
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
                              color: Colors.blue[400],
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(color: Colors.white),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipOval(
                            child: Container(
                              color: Colors.orange[300],
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        enabled: isEdit,
                        controller: userNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.grey[600])),
                      ),
                      TextField(
                        enabled: isEdit,
                        controller: emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey[600])),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlineButton(
                            borderSide: BorderSide(color: Colors.blue),
                            onPressed: () async {
                              //user.logout();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.remove('Infor');
                              Provider.of<AccountInf>(context, listen: false)
                                  .Logout();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Log out',
                              style: TextStyle(color: Colors.blue),
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
