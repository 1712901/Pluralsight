import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData dartTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      backgroundColor: Colors.grey[800],
      appBarTheme: AppBarTheme(
          color: Colors.grey[800],
          textTheme: TextTheme(
              headline4:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: TextTheme(
        headline3: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        headline4: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        headline5: TextStyle(
          color: Colors.white,
        ),
        headline6: TextStyle(color: Colors.white),
        bodyText1: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        bodyText2: TextStyle(color: Colors.grey[600]),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.grey),
        button: TextStyle(color: Colors.blue),
      ),
      dialogBackgroundColor: Colors.grey[800],
      popupMenuTheme: PopupMenuThemeData(color: Colors.grey[800]),
      cardTheme: CardTheme(color: Colors.grey[800]),
      iconTheme: IconThemeData(color: Colors.grey[300]),
      primaryIconTheme: IconThemeData(color: Colors.black),
      primaryColor: Colors.blue[400],
      accentColor: Colors.blue,
      disabledColor: Colors.white,
      unselectedWidgetColor: Colors.white,
      hintColor: Colors.grey,
      buttonColor: Colors.blue[400]);
  static final ThemeData lightThem = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(183, 195, 209, 1),
    backgroundColor: Color.fromRGBO(225, 230, 235, 1),
    dialogBackgroundColor: Color.fromRGBO(225, 230, 235, 1),
    popupMenuTheme: PopupMenuThemeData(color: Color.fromRGBO(225, 230, 235, 1)),
    appBarTheme: AppBarTheme(
        color: Color.fromRGBO(11, 145, 215, 1),
        textTheme: TextTheme(
            headline4:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: TextTheme(
      headline3: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      headline5: TextStyle(
        color: Colors.black,
      ),
      headline6: TextStyle(color: Colors.black),
      bodyText1: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      bodyText2: TextStyle(color: Colors.black26),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.blue),
    ),
    cardTheme: CardTheme(color: Color.fromRGBO(225, 230, 235, 1)),
    iconTheme: IconThemeData(color: Colors.black87),
    disabledColor: Colors.black,
    unselectedWidgetColor: Colors.black,
    primaryColor: Colors.white,
    hintColor: Colors.black,
    buttonColor: Colors.blue,
    accentColor: Colors.blue,
  );
}
