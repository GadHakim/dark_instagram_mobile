import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/news/news_bloc.dart';
import 'package:instagram/bloc/news/news_event.dart';
import 'package:instagram/bloc/news/news_state.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/text.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsItem> _news = [];

  NewsBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = BlocProvider.of<NewsBloc>(context);
    _initRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: darkBackgroundGradient(),
        ),
        child: BlocListener<NewsBloc, NewsState>(
          listener: (BuildContext context, NewsState state) => _blocListener(context, state),
          child: ListView.builder(
            itemCount: _news.length,
            itemBuilder: (BuildContext context, int index) {
              return _news[index]._buildNewsItem(context);
            },
          ),
        ),
      ),
    );
  }

  _blocListener(BuildContext context, NewsState state) {
    if (state is NewsLoadingState) {
      showLoadingDialog(context);
    } else if (state is NewsLoadedState) {
      closeLoadingDialog(context);
      _news = state.news;
    } else if (state is NewsErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: SizedBox.shrink(),
      title: Text('What\'s new'),
    );
  }

  _initRequest() {
    _newsBloc.add(FetchGetNewsEvent());
  }
}

abstract class NewsItem {
  Widget _buildNewsItem(BuildContext context);
}

class RecommendationItem extends NewsItem {
  @override
  Widget _buildNewsItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Recommendations for you',
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}

class PersonItem extends NewsItem {
  final Person _person;

  PersonItem(this._person);

  @override
  Widget _buildNewsItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 30.0,
            backgroundImage: _person.avatarImagePath != null
                ? NetworkImage(_person.avatarImagePath)
                : AssetImage('assets/images/user.png'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                trimStringToMaxChart('${_person.firstName} ${_person.lastName}'),
                maxLines: 1,
              ),
            ),
          ),
          RaisedButton(
            textColor: Colors.black,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Subscribe",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  static List<NewsItem> create(PeopleModel model) {
    List<NewsItem> news = [];

    model.result.forEach((Person person) {
      news.add(PersonItem(person));
    });

    return news;
  }
}
