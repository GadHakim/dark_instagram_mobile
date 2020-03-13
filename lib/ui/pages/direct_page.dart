import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/direct/direct_bloc.dart';
import 'package:instagram/bloc/direct/direct_event.dart';
import 'package:instagram/bloc/direct/direct_state.dart';
import 'package:instagram/data/models/direct_model.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';

class DirectPage extends StatefulWidget {
  @override
  _DirectPageState createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  DirectModel _directModel;

  DirectBloc _directBloc;

  @override
  void initState() {
    super.initState();
    _directBloc = BlocProvider.of<DirectBloc>(context);
    _initRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: darkBackgroundGradient(),
        ),
        child: BlocListener<DirectBloc, DirectState>(
          listener: (BuildContext context, DirectState state) => _blocListener(context, state),
          child: _buildContent(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[800],
      title: Text(
        'Direct',
        style: TextStyle(
          fontFamily: 'Billabong',
          fontSize: 24.0,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return RaisedButton(
      color: Colors.blueGrey[800],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Camera',
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildContent() {
    if (_directModel == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              prefixIcon: Icon(Icons.search),
              labelText: 'Search',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          child: Text(
            "Messages",
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _directModel.result.chats.length,
            itemBuilder: (BuildContext context, int index) {
              Chat chat = _directModel.result.chats[index];
              return MaterialButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 25.0,
                        backgroundImage: chat.avatarImagePath != null
                            ? NetworkImage(chat.avatarImagePath)
                            : AssetImage('assets/images/user.png'),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(chat.fullName),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                onPressed: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  _blocListener(BuildContext context, DirectState state) {
    if (state is DirectLoadingState) {
      showLoadingDialog(context);
    } else if (state is DirectLoadedState) {
      _directModel = state.directModel;
      closeLoadingDialog(context);
      setState(() {});
    } else if (state is DirectErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _initRequest() {
    _directBloc.add(FetchGetDirectEvent());
  }
}
