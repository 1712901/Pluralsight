import 'dart:convert';

import 'package:Pluralsight/service/UserService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      body: Builder(
        builder: (ctx) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  height: 20,
                ),
                TextFormField(
                  controller: userNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      emailInvalid(value) ? null : "Email không hợp lệ ",
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      phoneInvalid(value) ? null : "Số điện thoại không hợp lệ",
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => passwordInvalid(value)
                      ? null
                      : "Không chứa ký tự đặt biệt, chiều dài lớn hơn 8",
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Pasword',
                      labelStyle: TextStyle(color: Colors.grey[600])),
                ),
                TextFormField(
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
                      onPressed: () async {
                        int status = await registerAccount(
                            name: userNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            conf: confController.text,
                            phone: phoneController.text);

                        switch (status) {
                          case EMPTY_STRING_ERROR:
                            showToast(ctx, 'Cần nhập đầy đủ các trường !');
                            break;
                          case CONFIRM_ERROR:
                            showToast(ctx, 'Mật khẩu không khớp');
                            break;
                          case FORMAT_ERROR:
                            showToast(ctx, 'Sai định dạng');
                            break;
                          default:
                            if (status == 400) {
                              showToast(ctx, 'Tài khoản đã được đăng ký rồi !');
                            } else if (status == 500) {
                              showToast(ctx, 'Hiện tại không thể đăng ký !');
                            } else {
                              //await sendMail(emailController.text, ctx);
                              showToast(ctx, 'Đã gửi mail kích hoạt tài khoản');
                            }
                        }
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
      showToast(context, "Đã gửi mail kích hoạt tài khoản");
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

  bool emailInvalid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? invalid = false : invalid = true;
  }

  bool passwordInvalid(String password) {
    Pattern pattern = r'^[A-Za-z0-9]{8,}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(password)) ? invalid = false : invalid = true;
  }

  bool phoneInvalid(String phone) {
    Pattern pattern = r'[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(phone)) ? invalid = false : invalid = true;
  }
}
