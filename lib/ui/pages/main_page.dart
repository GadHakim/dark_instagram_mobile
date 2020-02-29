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
  MainAppBarItem _mainBarItem = allMainAppBarItem[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainBarItem.buildAppBar(),
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
          _mainBarItem = allMainAppBarItem[index];
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

abstract class MainAppBarItem {
  final IconData icon;

  const MainAppBarItem(this.icon);

  AppBar buildAppBar();
}

class MainHomeAppBarItem extends MainAppBarItem {
  MainHomeAppBarItem(IconData icon) : super(icon);

  @override
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[800],
      leading: IconButton(
        icon: Icon(Icons.camera_alt),
        onPressed: () {},
      ),
      title: Text(
        'Instagram',
        style: TextStyle(
          fontFamily: 'Billabong',
          fontSize: 24.0,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {},
        ),
      ],
    );
  }
}

class MainEmptyBarItem extends MainAppBarItem {
  MainEmptyBarItem(IconData icon) : super(icon);

  @override
  AppBar buildAppBar() {
    return null;
  }
}

List<MainAppBarItem> allMainAppBarItem = <MainAppBarItem>[
  MainHomeAppBarItem(Icons.home),
  MainEmptyBarItem(Icons.search),
  MainEmptyBarItem(Icons.add_box),
  MainEmptyBarItem(Icons.favorite),
  MainEmptyBarItem(Icons.person),
];
