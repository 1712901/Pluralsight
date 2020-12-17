import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast {
  static show({BuildContext context, String content}) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
