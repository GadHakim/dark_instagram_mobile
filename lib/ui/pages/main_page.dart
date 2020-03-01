import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/home/home_bloc.dart';
import 'package:instagram/bloc/news/news_bloc.dart';
import 'package:instagram/bloc/post_creation/post_creation_bloc.dart';
import 'package:instagram/bloc/search/search_bloc.dart';
import 'package:instagram/data/repositories/people_repository.dart';
import 'package:instagram/data/repositories/post_repository.dart';
import 'package:instagram/data/repositories/subscribers_repository.dart';
import 'package:instagram/ui/pages/home_page.dart';
import 'package:instagram/ui/pages/news_page.dart';
import 'package:instagram/ui/pages/post_creation_page.dart';
import 'package:instagram/ui/pages/search_page.dart';
import 'package:instagram/utils/http.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () => _navigateToPostCreationPage(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentTab,
          children: <Widget>[
            BlocProvider(
              child: HomePage(),
              create: (BuildContext context) {
                return HomeBloc(
                  peopleRepository: PeopleRepositoryImpl(
                    HttpImpl(),
                  ),
                  postRepository: PostRepositoryImpl(
                    HttpImpl(),
                  ),
                );
              },
            ),
            BlocProvider(
              child: SearchPage(),
              create: (BuildContext context) {
                return SearchBloc(
                  repository: PostRepositoryImpl(
                    HttpImpl(),
                  ),
                );
              },
            ),
            BlocProvider(
              child: NewsPage(),
              create: (BuildContext context) {
                return NewsBloc(
                  peopleRepository: PeopleRepositoryImpl(
                    HttpImpl(),
                  ),
                  subscribersRepository: SubscribersRepositoryImpl(
                    HttpImpl(),
                  ),
                );
              },
            ),
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

  void _navigateToPostCreationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: PostCreationPage(),
          create: (BuildContext context) {
            return PostCreationBloc(
              repository: PostRepositoryImpl(
                HttpImpl(),
              ),
            );
          },
        );
      }),
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
  MainAppBarItem(Icons.favorite),
  MainAppBarItem(Icons.person),
];
