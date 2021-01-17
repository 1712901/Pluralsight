import 'dart:convert';

import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.lock_outline,
                color: Colors.blue[400],
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                S.current.FORGET_PASSWORD,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.current.ProviderEmail,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    isDense: true,
                    icon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[600])),
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OTP()));
                          if (emailController.text.isNotEmpty) {
                            var res = await UserService.forgetPassword(
                                email: emailController.text);
                            Toast.show(
                                context: newContext,
                                content: jsonDecode(res.body)['message']);
                          }
                        },
                        child: Text(
                          S.current.Send,
                          style: TextStyle(color: Colors.white),
                        ),
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
