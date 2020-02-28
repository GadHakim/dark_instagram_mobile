import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/home/home_bloc.dart';
import 'package:instagram/bloc/home/home_event.dart';
import 'package:instagram/bloc/home/home_state.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/utils/alerts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PeopleModel _peopleModel;

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _initRequest(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
        title: Text(
          'Dark Instagram',
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
      ),
      body: BlocListener<HomeBloc, HomeState>(
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
        ],
      ),
    );
  }

  Widget _buildFavoriteContacts() {
    return Container(
      height: 120.0,
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
//                          backgroundColor: Colors.black.withOpacity(.5),
                      radius: 35.0,
                      backgroundImage: AssetImage('assets/images/add_user_history.png'),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    "Your History",
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
//                          backgroundColor: Colors.black.withOpacity(.5),
                    radius: 35.0,
                    backgroundImage: person.avatarImagePath != null
                        ? NetworkImage(person.avatarImagePath)
                        : AssetImage('assets/images/user.png'),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  "${person.firstName}",
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
