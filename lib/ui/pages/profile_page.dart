import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/profile/profile_bloc.dart';
import 'package:instagram/bloc/profile/profile_event.dart';
import 'package:instagram/bloc/profile/profile_state.dart';
import 'package:instagram/data/models/profile_model.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel _profileModel;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
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
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (BuildContext context, ProfileState state) => _blocListener(context, state),
          child: _buildContent(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: SizedBox.shrink(),
      title: Text(_profileModel != null ? _profileModel.result.fullName : ''),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  _blocListener(BuildContext context, ProfileState state) {
    if (state is ProfileLoadingState) {
      showLoadingDialog(context);
    } else if (state is ProfileLoadingState) {
      closeLoadingDialog(context);
    } else if (state is ProfileLoadedState) {
      closeLoadingDialog(context);
      _profileModel = state.profileModel;
      setState(() {});
    } else if (state is ProfileErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _initRequest() {
    _profileBloc.add(FetchGetProfileEvent());
  }

  Widget _buildContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildStatusLine(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(_profileModel != null ? _profileModel.result.fullName : ''),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  textColor: Colors.black,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            _buildUserGallery(),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Fill out the profile'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: '0 of 4',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: ' COMPLETED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            _buildFillProfile(),
          ],
        ),
      ),
    );
  }

  _buildStatusLine() {
    return Row(
      children: <Widget>[
        Image(
          height: 100.0,
          width: 100.0,
          image: AssetImage('assets/images/add_user_history.png'),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('32'),
              Text(trimStringToMaxChart('Publications', maxChart: 10)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('512'),
              Text(trimStringToMaxChart('Followers', maxChart: 10)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('128'),
              Text(trimStringToMaxChart('Subscriptions', maxChart: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserGallery() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image(
              width: MediaQuery.of(context).size.width / 3,
              image: AssetImage('assets/images/picture.png'),
            ),
            Image(
              width: MediaQuery.of(context).size.width / 3,
              image: AssetImage('assets/images/picture.png'),
            ),
            Image(
              width: MediaQuery.of(context).size.width / 3,
              image: AssetImage('assets/images/picture.png'),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Image(
              width: MediaQuery.of(context).size.width / 3,
              image: AssetImage('assets/images/picture.png'),
            ),
            Image(
              width: MediaQuery.of(context).size.width / 3,
              image: AssetImage('assets/images/picture.png'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFillProfile() {
    return Container(
      height: 240.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildFillProfileItem(
            'Add profile photo',
            'Select a photo for your\nInstagarm profile.',
            'Add a photo',
          ),
          _buildFillProfileItem(
            'Add biography',
            'Tell your subscribers\na little about yourself.',
            'Add a biography',
          ),
          _buildFillProfileItem(
            'Add your name',
            'Add first and last name\nso that friends know what it is',
            'Add name',
          ),
          _buildFillProfileItem(
            'Find someone to subscribe to,',
            'Subscribe to people and\ntopics that interest you.',
            'Find More',
          ),
        ],
      ),
    );
  }

  Widget _buildFillProfileItem(String title, String description, String buttonName) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Image(
                height: 100.0,
                width: 100.0,
                image: AssetImage('assets/images/user.png'),
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[200],
                ),
              ),
              RaisedButton(
                textColor: Colors.black,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    buttonName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
