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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
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
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                S.current.FORGET_PASSWORD,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                S.current.ProviderEmail,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    isDense: true,
                    icon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).iconTheme.color,
                      size: 30,
                    ),
                    labelText: 'Email',
                    labelStyle: Theme.of(context).textTheme.bodyText2),
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
                        color: Theme.of(context).primaryColor,
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
                          style: Theme.of(context).textTheme.subtitle1,
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
