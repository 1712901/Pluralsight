import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/ui/Account/ForgotPassword.dart';
import 'package:Pluralsight/View/ui/Account/SignUp.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:Pluralsight/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.SignIn,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: userNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showPassword,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: S.current.Password,
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = (!showPassword);
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: Builder(
                      builder: (newContext) => RaisedButton(
                        color: Colors.blue[400],
                        onPressed: () async {
                          String email = userNameController.text;
                          String password = passwordController.text;
                          if (email.isEmpty | password.isEmpty) {
                            return;
                          }

                          var res = await UserService.login(
                              email: email, password: password);
                          if (res == null) {
                            print('Error');
                            return;
                          }
                          if (res.statusCode == 400) {
                            Toast.show(
                                context: newContext,
                                content: (jsonDecode(res.body))['message']);
                          } else if (res.statusCode == 403) {
                            Toast.show(
                                context: newContext,
                                content: (jsonDecode(res.body))['message']);
                          } else if (res.statusCode == 200) {
                            Provider.of<AccountInf>(context, listen: false)
                                .setAcountInf(res.body);
                                //save data
                            final storage = new FlutterSecureStorage();
                            await storage.write(key: "token", value: jsonDecode(res.body)["token"]);
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setString('Infor', res.body);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          } else {
                            print(res.body);
                          }
                        },
                        child: Text(
                          S.current.SignIn,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Text(
                      S.current.FORGET_PASSWORD,
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    borderSide: BorderSide(color: Colors.blue),
                    child: Text(
                      S.current.SIGN_UP_FREE,
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
