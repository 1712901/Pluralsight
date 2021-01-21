import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/Format.dart';
import 'package:Pluralsight/Core/models/Toast.dart';
import 'package:Pluralsight/Core/service/UserService.dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:Pluralsight/View/ui/Constant.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController;
  TextEditingController confController;
  bool showPassword = false;
  bool showConfPassword = false;
  bool invalid=false;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    confController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confController.dispose();
    super.dispose();
  }

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
                S.current.SetNewPassword,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
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
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: S.current.NewPassword,
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
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    labelText: S.current.ConfirmPassword,
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
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
                        color: Colors.blue[400],
                        onPressed: () async {
                          switch (checkFormat()) {
                            case 0:
                              Response res = await UserService.resetPassword(
                                  idUser: Provider.of<AccountInf>(context,
                                          listen: false)
                                      .userInfo
                                      .id,
                                  password: newPasswordController.text);
                              if(res.statusCode==200){
                                Toast.show(
                                  context: ctx, content: S.current.PasswordHasBeenUpdated);
                              }else{
                                Toast.show(
                                  context: ctx, content: S.current.AccountDoesNotExist);
                              }
                              break;
                            case ConstanUI.EMPTY_ERROR:
                              Toast.show(
                                  context: ctx, content: S.current.EmptyContent);
                              break;
                            case ConstanUI.CONFIRM_ERROR:
                              Toast.show(
                                  context: ctx, content: S.current.ConfirmNotMatch);
                              break;
                            case ConstanUI.LENGTH_ERROR:
                              Toast.show(
                                  context: ctx,
                                  content: S.current.PasswordLength);
                              break;
                          }
                        },
                        child: Text(
                          'UPADTE',
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

  int checkFormat() {
    if (newPasswordController.text.isEmpty || confController.text.isEmpty) {
      return ConstanUI.EMPTY_ERROR;
    } else if (newPasswordController.text != confController.text) {
      return ConstanUI.CONFIRM_ERROR;
    } else if (newPasswordController.text.length < 8) {
      return ConstanUI.LENGTH_ERROR;
    }
    return 0;
  }
}
