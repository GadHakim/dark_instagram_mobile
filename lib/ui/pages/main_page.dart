import 'package:flutter/material.dart';
import 'package:instagram/ui/pages/home_page.dart';
import 'package:instagram/ui/pages/post_creation_page.dart';
import 'package:instagram/ui/pages/search_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentTab,
          children: <Widget>[
            HomePage(),
            SearchPage(),
            PostCreationPage(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.blueGrey[900],
      currentIndex: _currentTab,
      onTap: (int index) {
        setState(() {
          _currentTab = index;
        });
      },
      items: allMainAppBarItem.map((MainAppBarItem destination) {
        return BottomNavigationBarItem(
          icon: Icon(destination.icon),
          title: SizedBox.shrink(),
        );
      }).toList(),
    );
  }
}

class MainAppBarItem {
  final IconData icon;

  const MainAppBarItem(this.icon);
}

List<MainAppBarItem> allMainAppBarItem = <MainAppBarItem>[
  MainAppBarItem(Icons.home),
  MainAppBarItem(Icons.search),
  MainAppBarItem(Icons.add_box),
  MainAppBarItem(Icons.favorite),
  MainAppBarItem(Icons.person),
];
