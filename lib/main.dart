import 'package:Pluralsight/Page/BrowsePage.dart';
import 'package:Pluralsight/Page/DowloadPage.dart';
import 'package:Pluralsight/Page/HomePage.dart';
import 'package:Pluralsight/Page/SearchPage.dart';
import 'package:Pluralsight/Page/SignIn.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SignIn(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 3;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  List<Widget> optionSlected = [
    HomePage(title: 'Home',),
    DownLoadsPage(),
    BrowsePase(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: optionSlected[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download,
            ),
            label: 'Downloads'
          ),
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
            label: 'Search'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}
