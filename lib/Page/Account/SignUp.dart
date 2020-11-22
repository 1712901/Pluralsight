import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Colors.grey[400],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please signup to continue',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: userNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Pasword',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              TextField(
                controller: confController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.grey[600])),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      registerAccount(
                          name: userNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          conf: confController.text);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue[400],
                  )),
              SizedBox(
                width: double.infinity,
                child: OutlineButton(
                    borderSide: BorderSide(color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Already have account? Login',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerAccount(
      {String name, String email, String password, String conf}) {
    print(
        'Name: ${name}\nEmail: ${email}\nPassword: ${password}\nConf: ${conf}');
  }
}
