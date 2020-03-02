import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/search/search_bloc.dart';
import 'package:instagram/bloc/search/search_event.dart';
import 'package:instagram/bloc/search/search_state.dart';
import 'package:instagram/data/models/all_post_model.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchItem> _searchList = [];
  List<_SearchCategoryItem> _categories = [
    _SearchCategoryItem("IGTV", icon: Icons.tv),
    _SearchCategoryItem("Shop", icon: Icons.shopping_cart),
    _SearchCategoryItem("Auto"),
    _SearchCategoryItem("TV and Films"),
    _SearchCategoryItem("Travels"),
    _SearchCategoryItem("Games"),
    _SearchCategoryItem("Food"),
    _SearchCategoryItem("Style"),
    _SearchCategoryItem("Comics"),
    _SearchCategoryItem("Science and technology"),
    _SearchCategoryItem("Animals"),
    _SearchCategoryItem("Music"),
    _SearchCategoryItem("Decor"),
  ];

  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _initRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (BuildContext context, SearchState state) => _blocListener(context, state),
        child: Container(
          decoration: BoxDecoration(
            gradient: darkBackgroundGradient(),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 60.0,
                child: _buildCategories(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _searchList[index]._buildSearchItem(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (BuildContext context, int index) {
        _SearchCategoryItem item = _categories[index];
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Visibility(
                    visible: item.icon != null,
                    child: Icon(
                        _categories[index].icon
                    ),
                  ),
                  Visibility(
                    visible: item.icon != null,
                    child: SizedBox(width: 10),
                  ),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.center_focus_weak),
          onPressed: () {},
        )
      ],
      title: Text(
        'Find',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  _blocListener(BuildContext context, SearchState state) {
    if (state is SearchLoadingState) {
      showLoadingDialog(context);
    } else if (state is SearchLoadedState) {
      closeLoadingDialog(context);
      _searchList = state.searchList;
    } else if (state is SearchErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _initRequest() {
    _searchBloc.add(FetchGetAllPostsEvent());
  }
}

abstract class SearchItem {
  static const int MAX_ITEM_COUNT = 3;
  List<AllPost> _list = [];

  Widget _buildSearchItem(BuildContext context);

  fillList(List<AllPost> list);

  static List<SearchItem> fromModel(AllPostModel allPostModel) {
    List<SearchItem> searchList = [];
    int currentItemIndex = 0;

    while (allPostModel.result.length >= MAX_ITEM_COUNT) {
      if (currentItemIndex == 0) {
        searchList.add(SearchSmallImagesItem.fromList(
          allPostModel.result,
        ));
      } else if (currentItemIndex == 1) {
        searchList.add(SearchSmallImagesWithBigLeftItem.fromList(
          allPostModel.result,
        ));
      } else if (currentItemIndex == 2) {
        searchList.add(SearchSmallImagesWithBigRightItem.fromList(
          allPostModel.result,
        ));
      }

      currentItemIndex++;
      if (currentItemIndex > MAX_ITEM_COUNT) {
        currentItemIndex = 0;
      }
    }

    return searchList;
  }
}

class SearchSmallImagesItem extends SearchItem {
  SearchSmallImagesItem.fromList(List<AllPost> list) {
    fillList(list);
  }

  @override
  Widget _buildSearchItem(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / _list.length,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _list.map((AllPost item) {
              return Image(
                height: MediaQuery.of(context).size.width / _list.length,
                width: MediaQuery.of(context).size.width / _list.length,
                image: NetworkImage(item.content[0].contentPath),
                fit: BoxFit.cover,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  @override
  fillList(List<AllPost> list) {
    for (int i = 0; i < SearchItem.MAX_ITEM_COUNT; i++) {
      if (list.length != 0) {
        _list.add(list.removeAt(0));
      }
    }
  }
}

class SearchSmallImagesWithBigLeftItem extends SearchItem {
  SearchSmallImagesWithBigLeftItem.fromList(List<AllPost> list) {
    fillList(list);
  }

  @override
  Widget _buildSearchItem(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / _list.length * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / _list.length * 2,
            width: MediaQuery.of(context).size.width / _list.length * 2,
            image: NetworkImage(_list[0].content[0].contentPath),
          ),
          Column(
            children: <Widget>[
              Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / _list.length,
                width: MediaQuery.of(context).size.width / _list.length,
                image: NetworkImage(_list[1].content[0].contentPath),
              ),
              Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / _list.length,
                width: MediaQuery.of(context).size.width / _list.length,
                image: NetworkImage(_list[2].content[0].contentPath),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  fillList(List<AllPost> list) {
    for (int i = 0; i < SearchItem.MAX_ITEM_COUNT; i++) {
      if (list.length != 0) {
        _list.add(list.removeAt(0));
      }
    }
  }
}

class SearchSmallImagesWithBigRightItem extends SearchItem {
  SearchSmallImagesWithBigRightItem.fromList(List<AllPost> list) {
    fillList(list);
  }

  @override
  Widget _buildSearchItem(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / _list.length * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / _list.length,
                width: MediaQuery.of(context).size.width / _list.length,
                image: NetworkImage(_list[0].content[0].contentPath),
              ),
              Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / _list.length,
                width: MediaQuery.of(context).size.width / _list.length,
                image: NetworkImage(_list[1].content[0].contentPath),
              )
            ],
          ),
          Image(
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / _list.length * 2,
            width: MediaQuery.of(context).size.width / _list.length * 2,
            image: NetworkImage(_list[2].content[0].contentPath),
          ),
        ],
      ),
    );
  }

  @override
  fillList(List<AllPost> list) {
    for (int i = 0; i < SearchItem.MAX_ITEM_COUNT; i++) {
      if (list.length != 0) {
        _list.add(list.removeAt(0));
      }
    }
  }
}

class _SearchCategoryItem {
  final String title;
  IconData icon;

  _SearchCategoryItem(this.title, {this.icon});
}
