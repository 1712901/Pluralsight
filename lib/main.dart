import 'dart:convert';

import 'package:Pluralsight/Core/models/AccountInf.dart';
import 'package:Pluralsight/Core/models/DownloadModel.dart';
import 'package:Pluralsight/Core/models/FavoriteCourses.dart';
import 'package:Pluralsight/Core/models/LoadURL.dart';
import 'package:Pluralsight/Core/models/Response/ResFavoriteCourses.dart';
import 'package:Pluralsight/Core/models/Response/ResGetProfile.dart';
import 'package:Pluralsight/Core/models/SearchBuilder/SearchOption.dart';
import 'package:Pluralsight/Core/models/User.dart';
import 'package:Pluralsight/Core/models/TopCourses.Dart';
import 'package:Pluralsight/Core/models/MyProvider/DownloadProgress.dart';
import 'package:Pluralsight/Theme/AppTheme.dart';
import 'package:Pluralsight/View/ui/Account/SignIn.dart';
import 'package:Pluralsight/View/ui/Browser/BrowserPage.dart';
import 'package:Pluralsight/View/ui/Download/DowloadPage.dart';
import 'package:Pluralsight/View/ui/Home/HomePage.dart';
import 'package:Pluralsight/View/ui/Search/SearchPage.dart';
import 'package:Pluralsight/View/ui/Account/Profile.Dart';
import 'package:Pluralsight/generated/l10n.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'Core/models/MyProvider/ThemeModeApp.dart';
import 'Core/service/UserService.dart';
import 'View/ui/Account/DoneUpdatePassword.dart';
import 'View/ui/Account/ForgotPassword.dart';
import 'View/ui/Account/SignUp.dart';
import 'View/ui/Account/UpdatePassword.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountInf(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteCourses(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopCourses(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchOption(),
        ),
        ChangeNotifierProvider(
          create: (_) => DownloadModel(),
        ),
        ChangeNotifierProvider(create: (_) => LoadURL()),
        ChangeNotifierProvider(create: (_) => DownLoadProgress()),
        ChangeNotifierProvider(create: (_) => ThemeModeApp()),
      ],
      child: Consumer<ThemeModeApp>(builder: (context, provider, _) {
        return MaterialApp(
          theme: AppTheme.lightThem,
          darkTheme: AppTheme.dartTheme,
          themeMode: provider.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          home: Home(),
          //home: UpdatePassword(),
        );
      }),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> loadInforAccount() async {
    final storage = new FlutterSecureStorage();
    String valueToken = await storage.read(key: "token");
    bool onDartMode = (await storage.read(key: "Them")).toLowerCase() == "true";
    Provider.of<ThemeModeApp>(context, listen: false).updateTheme(onDartMode);
    if (valueToken != null) {
      Provider.of<AccountInf>(context, listen: false)
          .setToken(token: valueToken);
      Response res = await UserService.getFavoriteCourses(token: valueToken);
      if (res.statusCode == 200) {
        ResFavoriteCourses resFavoriteCourses =
            ResFavoriteCourses.fromJson(jsonDecode(res.body));
        Provider.of<FavoriteCourses>(context, listen: false).setFavoriteCourses(
            favoriteCourses: resFavoriteCourses.favoriteCourse);
      } else {
        Provider.of<AccountInf>(context, listen: false).setToken(token: null);
      }
      res = await UserService.getProfile(token: valueToken);
      if (res.statusCode == 200) {
        ResGetProfile resGetProfile =
            ResGetProfile.fromJson(jsonDecode(res.body));
        Provider.of<AccountInf>(context, listen: false)
            .setUserInfor(resGetProfile.userInfo);
      } else {
        Provider.of<AccountInf>(context, listen: false).setToken(token: null);
      }
    }
  }

  @override
  void initState() {
    loadInforAccount();
    super.initState();
  }

  void onItemTapped(int index) {
    if (index == 1 && !context.read<AccountInf>().isAuthorization()) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignIn(),
          settings: RouteSettings(name: "SignIn")));
    } else {
      setState(() {
        _selectedIndex = index;
        navigatorKey.currentState.popUntil((route) => route.isFirst);
      });
    }
  }

  List<Widget> optionSlected = [
    HomePage(
      title: S.current.Home,
    ),
    DownLoadsPage(),
    BrowsePase(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: CustomNavigator(
        home: optionSlected[_selectedIndex],
        navigatorKey: navigatorKey,
        pageRoute: PageRoutes.cupertinoPageRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.file_download,
              ),
              label: 'Downloads'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_module,
            ),
            label: "Browse",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).disabledColor,
        onTap: onItemTapped,
      ),
    );
  }
}
