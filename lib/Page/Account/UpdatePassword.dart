import 'package:Pluralsight/Page/Account/DoneUpdatePassword.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool showPassword = false;
  bool showConfPassword = false;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confController = TextEditingController();
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'NEW CREDANTIALS',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your idential has been verified!\nSet your new password',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: newPasswordController,
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
              TextField(
                controller: confController,
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showPassword,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showConfPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          showConfPassword = (!showConfPassword);
                        });
                      },
                    )),
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blue[400],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Done()));
                        },
                        child: Text(
                          'UPADTE',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
