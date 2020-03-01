import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/sign_up/sign_up_bloc.dart';
import 'package:instagram/bloc/sign_up/sign_up_event.dart';
import 'package:instagram/bloc/sign_up/sign_up_state.dart';
import 'package:instagram/data/store.dart';
import 'package:instagram/ui/pages/main_page.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/keyboard.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  SignUpBloc _signUpBloc;

  Store _store;

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
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
                    "Sign Up",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                onPressed: () => _signUpRequest(context),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
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
                            onChanged: (firstName) {
                              _firstName = firstName;
                            },
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeFirstName,
                            onFieldSubmitted: (term) {
                              _focusNodeFirstName.unfocus();
                              FocusScope.of(context).requestFocus(_focusNodeLastName);
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                                ),
                                hintText: 'First Name'),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            onChanged: (lastName) {
                              _lastName = lastName;
                            },
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeLastName,
                            onFieldSubmitted: (term) {
                              _focusNodeLastName.unfocus();
                              FocusScope.of(context).requestFocus(_focusNodeEmail);
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                                ),
                                hintText: 'Last Name'),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
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
                                  borderSide: BorderSide(color: Theme.of(context).accentColor),
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
                            onFieldSubmitted: (term) => _signUpRequest(context),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                                ),
                                hintText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        SizedBox(
                          height: 64.0,
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

  _blocListener(BuildContext context, SignUpState state) {
    print(state);
    if (state is SignUpLoadingState) {
      showLoadingDialog(context);
    } else if (state is SignUpLoadedState) {
      closeLoadingDialog(context);
      _store.signUpModel = state.signUpModel;
      _navigateToHomePage(context);
    } else if (state is SignUpErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _signUpRequest(BuildContext context) {
    closeKeyboard(context);
    _signUpBloc.add(FetchSignUpEvent(
      _firstName.trim(),
      _lastName.trim(),
      _email.trim(),
      _password.trim(),
    ));
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MainPage();
      }),
    );
  }
}
