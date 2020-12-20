import 'dart:convert';
import 'dart:ffi';

import 'package:Pluralsight/Page/Account/SignIn.dart';
import 'package:Pluralsight/Page/BrowsePage.dart';
import 'package:Pluralsight/Page/DowloadPage.dart';
import 'package:Pluralsight/Page/HomePage.dart';
import 'package:Pluralsight/Page/SearchPage.dart';
import 'package:Pluralsight/models/Author.dart';
import 'package:Pluralsight/models/CourseDetail.dart';
import 'package:Pluralsight/models/CourseList.dart';
import 'package:Pluralsight/models/DownloadModel.dart';
import 'package:Pluralsight/models/FavoriteCourses.dart';
import 'package:Pluralsight/models/MyChannelList.dart';
import 'package:Pluralsight/models/Response/ResFavoriteCourses.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:Pluralsight/models/AccountInf.dart';
import 'package:Pluralsight/models/TopCourses.Dart';
import 'package:Pluralsight/service/UserService.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
          create: (_) => CourseListModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyChannelListModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DownloadModel(),
        ),
        Provider(
          create: (_) => CourseDetailListModel(),
        ),
        Provider(
          create: (_) => AuthorsModel(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.grey[800],
            accentColor: Colors.cyan[600],
            backgroundColor: Colors.black87,
            buttonColor: Colors.grey),
        home: Home(),
      ),
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
    if (valueToken != null) {
      Provider.of<AccountInf>(context, listen: false)
          .setToken(token: valueToken);
      Response res = await UserService.getFavoriteCourses(token: valueToken);
      if (res.statusCode == 200) {
        ResFavoriteCourses resFavoriteCourses =
            ResFavoriteCourses.fromJson(jsonDecode(res.body));
        Provider.of<FavoriteCourses>(context, listen: false).setFavoriteCourses(
            favoriteCourses: resFavoriteCourses.favoriteCourse);
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
      title: 'Home',
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
        backgroundColor: Colors.grey[800],
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
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}
