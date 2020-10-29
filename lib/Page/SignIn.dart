import 'package:Pluralsight/Page/ForgotPassword.dart';
import 'package:Pluralsight/Page/SignUp.dart';
import 'package:flutter/material.dart';

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
              //Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign In',
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
                    labelText: 'Username (or Email)',
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
                    labelText: 'Password',
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
                    child: RaisedButton(
                      color: Colors.blue[400],
                      onPressed: () {
                        checkUser(
                            password: passwordController.text,
                            username: userNameController.text);
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(color: Colors.white),
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
                      'FORGOT PASSWORD ?',
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
                      'SIGN UP FREE',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
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
