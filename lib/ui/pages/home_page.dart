import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/home/home_bloc.dart';
import 'package:instagram/bloc/home/home_event.dart';
import 'package:instagram/bloc/home/home_state.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/models/subscribers_posts_model.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/text.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PeopleModel _peopleModel;
  SubscribersPostsModel _subscribersPostsModel;

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _initRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: darkBackgroundGradient(),
      ),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) => _blocListener(context, state),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, state) {
            if (state is HomeLoadingState) {
              return _buildHomeLoading();
            } else if (state is HomeLoadedState) {
              return _buildHomeLoaded();
            } else if (state is HomeErrorState) {
              return _buildHomeError();
            } else {
              return _buildHomeUnknownError();
            }
          },
        ),
      ),
    );
  }

  _blocListener(BuildContext context, HomeState state) {
    if (state is HomeLoadingState) {
      showLoadingDialog(context);
    } else if (state is HomeLoadedState) {
      closeLoadingDialog(context);
      _peopleModel = state.peopleModel;
      _subscribersPostsModel = state.subscribersPostsModel;
    } else if (state is HomeErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
    print(state);
  }

  _initRequest(BuildContext context) {
    _homeBloc.add(FetchHomeEvent());
  }

  Widget _buildHomeLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildHomeLoaded() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildFavoriteContacts(),
          _buildPosts(),
        ],
      ),
    );
  }

  Widget _buildFavoriteContacts() {
    return Container(
      height: 105.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _peopleModel.result.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/add_user_history.png'),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    trimStringToMaxChart("Your History"),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          Person person = _peopleModel.result[index - 1];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30.0,
                    backgroundImage: person.avatarImagePath != null
                        ? NetworkImage(person.avatarImagePath)
                        : AssetImage('assets/images/user.png'),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  trimStringToMaxChart("${person.firstName}"),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPosts() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0),
            ),
          ),
          child: ListView.builder(
            itemCount: _subscribersPostsModel.result.length,
            itemBuilder: (BuildContext context, int index) {
              final SubscribersPost subscribersPost = _subscribersPostsModel.result[index];
              final controller = PageController();
              final valueNotifier = ValueNotifier(0);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 20.0,
                                backgroundImage: subscribersPost.postCreator.avatarImagePath != null
                                    ? NetworkImage(subscribersPost.postCreator.avatarImagePath)
                                    : AssetImage('assets/images/user.png'),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "${subscribersPost.postCreator.firstName}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: subscribersPost.contentHeight.toDouble() / 2,
                    child: PageView.builder(
                        onPageChanged: (index) {
                          valueNotifier.value = index;
                        },
                        controller: controller,
                        itemCount: subscribersPost.content.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            subscribersPost.content[index].contentPath,
                            fit: BoxFit.cover,
                          );
                        }),
                  ),
                  Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 8.0,
                                top: 8.0,
                                bottom: 8.0,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.message,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.send,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 8.0,
                                left: 8.0,
                                right: 8.0,
                                bottom: 8.0,
                                child: PageViewIndicator(
                                  length: subscribersPost.content.length,
                                  normalBuilder: (animationController, index) => Circle(
                                    size: 8.0,
                                    color: Colors.grey,
                                  ),
                                  highlightedBuilder: (animationController, index) =>
                                      ScaleTransition(
                                    scale: CurvedAnimation(
                                      parent: animationController,
                                      curve: Curves.ease,
                                    ),
                                    child: Circle(
                                      size: 8.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  pageIndexNotifier: valueNotifier,
                                ),
                              ),
                              Positioned(
                                right: 8.0,
                                top: 8.0,
                                bottom: 8.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.turned_in_not,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Like: ${subscribersPost.likeCount}'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(subscribersPost.comment),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('View all comments: ${subscribersPost.comments.length}'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 12.0,
                                backgroundImage: AssetImage('assets/images/user.png'),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Add a comment...",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 16.0,
                            ),
                            SizedBox(width: 8.0),
                            Icon(
                              Icons.sentiment_satisfied,
                              size: 16.0,
                            ),
                            SizedBox(width: 8.0),
                            Icon(
                              Icons.add_circle_outline,
                              size: 16.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "9 hours ago",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "Show translate",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Loading Error'),
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Refresh",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            onPressed: () => _initRequest(context),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeUnknownError() {
    return Center(
      child: Text('BlocBuilder Error'),
    );
  }
}
