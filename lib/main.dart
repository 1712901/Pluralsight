import 'package:Pluralsight/Page/DowloadPage.dart';
import 'package:Pluralsight/Page/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  List<Widget> optionSlected = [
    HomePage(title: 'Home',),
    DownLoadsPage(),
    HomePage(title: 'Browse',),
    HomePage(title: 'Search',),
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
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download,
            ),
            title: Text('Downloads'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_module,
            ),
            title: Text('Browse'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title: Text('Search'),
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
