import 'dart:convert';

import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';

const urlRegis = "http://api.dev.letstudy.org/user/register";
const urlSendmail = "http://api.dev.letstudy.org/user/send-activate-email";
const int EMPTY_STRING_ERROR = -1;
const int CONFIRM_ERROR = -2;
const int FORMAT_ERROR = -3;
bool invalid = false;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController confController;
  TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    confController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    confController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
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
      body: Builder(
        builder: (ctx) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  S.current.PleaseSignupToContinue,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: userNameController,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: S.current.Name,
                      labelStyle: Theme.of(context).textTheme.subtitle2),
                ),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    invalid=Format.emailInvalid(value);
                    if(invalid) return null;
                    else return S.current.InvalidEmail;
                  },
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Email',
                      labelStyle: Theme.of(context).textTheme.subtitle2),
                ),
                TextFormField(
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:(value){
                    invalid=Format.phoneInvalid(value);
                    if(invalid) return null;
                    else return S.current.InvalidPhoneNumber;
                  },
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: S.current.Phone,
                      labelStyle:Theme.of(context).textTheme.subtitle2),
                ),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:(value){
                    invalid=Format.passwordInvalid(value);
                    if(invalid) return null;
                    else return S.current.SpecialCharacters;
                  },
                  obscureText: true,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: S.current.Password,
                      labelStyle: Theme.of(context).textTheme.subtitle2),
                ),
                TextFormField(
                  controller: confController,
                  obscureText: true,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: S.current.ConfirmPassword,
                      labelStyle: Theme.of(context).textTheme.subtitle2),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        int status = await registerAccount(
                            name: userNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            conf: confController.text,
                            phone: phoneController.text);

                        switch (status) {
                          case EMPTY_STRING_ERROR:
                            showToast(ctx, S.current.EmptyContent);
                            break;
                          case CONFIRM_ERROR:
                            showToast(ctx, S.current.ConfirmPassword);
                            break;
                          case FORMAT_ERROR:
                            showToast(ctx, S.current.WrongFormat);
                            break;
                          default:
                            if (status == 400) {
                              showToast(ctx, S.current.AccountAlreadyRegistered);
                            } else if (status == 500) {
                              showToast(ctx, '!');
                            }else if(status==200){
                              //await sendMail(emailController.text, ctx);
                              Toast.show(context: ctx,content: "Tài khoản đã được đăng ký vui lòng kiểm tra email");
                            }
                            else {
                              //await sendMail(emailController.text, ctx);
                              showToast(ctx, S.current.CurrentlyUnableToRegister);
                            }
                        }
                      },
                      child: Text(
                        S.current.SignUp,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      color: Theme.of(context).accentColor,
                    )),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                      borderSide: BorderSide(color: Theme.of(context).accentColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.current.AlreadyHaveAccount,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> registerAccount(
      {String name,
      String email,
      String password,
      String conf,
      String phone}) async {
    if (password != conf) {
      return CONFIRM_ERROR;
    }
    if (!invalid) {
      return FORMAT_ERROR;
    }
    if (name.isEmpty |
        email.isEmpty |
        phone.isEmpty |
        conf.isEmpty |
        password.isEmpty) {
      return EMPTY_STRING_ERROR;
    }
    var res = await UserService.registerAccount(
        username: name, email: email, phone: phone, password: password);
    return res.statusCode;
  }

  void sendMail(String email, BuildContext context) async {
    var response = await UserService.sendMail(email);
    if (response.statusCode == 400) {
      showToast(context, response.body);
    } else {
      showToast(context, S.current.SendMail);
    }
  }

  void showToast(BuildContext context, String content) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${content}'),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


}
