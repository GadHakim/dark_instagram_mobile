import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/home/home_bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_event.dart';
import 'package:instagram/bloc/sign_in/sign_in_state.dart';
import 'package:instagram/data/repositories/people_repository.dart';
import 'package:instagram/data/repositories/post_repository.dart';
import 'package:instagram/data/store.dart';
import 'package:instagram/ui/pages/home_page.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/http.dart';
import 'package:instagram/utils/keyboard.dart';

class SignInPage extends StatefulWidget {
  SignInPage();

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  String _email = '';
  String _password = '';

  SignInBloc _signInBloc;

  Store _store;

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _store = Store();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                onPressed: () => _signInRequest(context),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) => _blocListener(context, state),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: darkBackgroundGradient(),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        BackButton(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Center(
                      child: Text(
                        'Instagram',
                        style: TextStyle(
                          fontFamily: 'Billabong',
                          fontSize: 48.0,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            onChanged: (email) {
                              _email = email;
                            },
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeEmail,
                            onFieldSubmitted: (term) {
                              _focusNodeEmail.unfocus();
                              FocusScope.of(context).requestFocus(_focusNodePassword);
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                                hintText: 'Email'),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            onChanged: (password) {
                              _password = password;
                            },
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodePassword,
                            onFieldSubmitted: (term) => _signInRequest(context),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                                hintText: 'Password'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _blocListener(BuildContext context, SignInState state) {
    if (state is SignInLoadingState) {
      showLoadingDialog(context);
    } else if (state is SignInLoadedState) {
      closeLoadingDialog(context);
      _store.token = state.signInModel;
      _navigateToHomePage(context);
    } else if (state is SignInErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _signInRequest(BuildContext context) {
    closeKeyboard(context);
    _signInBloc.add(FetchSignInEvent(
      _email.trim(),
      _password.trim(),
    ));
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
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
        );
      }),
    );
  }
}
