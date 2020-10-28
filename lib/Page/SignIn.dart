import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = true;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: userNameController,
                cursorColor: Theme.of(context).cursorColor,
                style: TextStyle(
                  color: Colors.grey[100],
                ),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  labelText: 'Username(or Email)',
                  labelStyle: TextStyle(
                    color: Colors.blue[800],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[800]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showPassword,
                style: TextStyle(
                  color: Colors.grey[100],
                ),
                decoration: InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.blue[800],
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[800]),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.grey[800],
                      onPressed: () {
                        checkUser(
                            password: passwordController.text,
                            username: userNameController.text);
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'FORGOT PASSWORD ?',
                    style: TextStyle(color: Colors.blue),
                  )),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    borderSide: BorderSide(color: Colors.blue),
                    onPressed: () {},
                    child: Text(
                      'USE SINGLE SIGN-ON (SSO)',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'SIGN UP FREE',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool checkUser({String username, String password}) {
    if (username.isEmpty || password.isEmpty) {
      return false;
    } else {
      print(
          "UserName:${userNameController.text}\nPassword: ${passwordController.text}");
    }
    return true;
  }
}
