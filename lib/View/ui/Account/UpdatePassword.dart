import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/HandleAdd2Channel.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/View/ui/Account/DoneUpdatePassword.dart';
import 'package:Pluralsight/View/ui/Constant.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool showPassword = false;
  bool showConfPassword = false;
  bool showOldPassword = false;
  TextEditingController oldPasswordController;
  TextEditingController newPasswordController;
  TextEditingController confController;
  bool invalid=false;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    confController = TextEditingController();
    oldPasswordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    newPasswordController.dispose();
    confController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'NEW CREDANTIALS',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                S.current.InfoUpdatePassword,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: oldPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:(value){
                  invalid=Format.passwordInvalid(value);
                  if(invalid) return null;
                  else return S.current.PasswordLength;
                },
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showOldPassword,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    labelText: S.current.OldPassword,
                    labelStyle:Theme.of(context).textTheme.subtitle2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showOldPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          showOldPassword = (!showOldPassword);
                        });
                      },
                    )),
              ),
              TextFormField(
                controller: newPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:(value){
                  invalid=Format.passwordInvalid(value);
                  if(invalid) return null;
                  else return S.current.PasswordLength;
                },
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showPassword,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    labelText: S.current.NewPassword,
                    labelStyle: Theme.of(context).textTheme.subtitle2,
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
              TextFormField(
                controller: confController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:(value){
                  invalid=Format.passwordInvalid(value);
                  if(invalid) return null;
                  else return S.current.PasswordLength;
                },
                cursorColor: Theme.of(context).cursorColor,
                obscureText: !showPassword,
                style:Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                    labelText: S.current.ConfirmPassword,
                    labelStyle: Theme.of(context).textTheme.subtitle2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showConfPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey[300],
                      ),
                      onPressed: () {
                        setState(() {
                          showConfPassword = (!showConfPassword);
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
                    child: Builder(
                      builder: (ctx) => RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          switch (checkFormat()) {
                            case 0:
                              Response res = await UserService.changePassword(
                                  token: Provider.of<AccountInf>(context,
                                          listen: false)
                                      .token,
                                  idUser: Provider.of<AccountInf>(context,
                                          listen: false)
                                      .userInfo
                                      .id,
                                  oldPass: oldPasswordController.text,
                                  newPass: newPasswordController.text);
                              print(res.body);
                              if (res.statusCode == 200) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Done()));
                              } else if (res.statusCode == 400) {
                                Toast.show(context: ctx,content: S.current.PasswordIncorrect);
                              }
                              break;
                            case ConstanUI.EMPTY_ERROR:
                              Toast.show(context:ctx,content: S.current.EmptyContent);
                              break;
                            case ConstanUI.CONFIRM_ERROR:
                              Toast.show(context:ctx,content: S.current.PasswordLength);
                              Toast.show(context:ctx,content: S.current.ConfirmNotMatch);
                              break;
                            case ConstanUI.LENGTH_ERROR:
                              Toast.show(context:ctx,content: S.current.ConfirmNotMatch);
                              break;
                          }
                        },
                        child: Text(
                          S.current.Update,
                          style: Theme.of(context).textTheme.bodyText1,
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

  int checkFormat() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confController.text.isEmpty) {
      return ConstanUI.EMPTY_ERROR;
    } else if (newPasswordController.text != confController.text) {
      return ConstanUI.CONFIRM_ERROR;
    } else if (newPasswordController.text.length < 8) {
      return ConstanUI.LENGTH_ERROR;
    }
    return 0;
  }
}
