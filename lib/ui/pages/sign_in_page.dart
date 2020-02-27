import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_event.dart';
import 'package:instagram/bloc/sign_in/sign_in_state.dart';
import 'package:instagram/utils/alerts.dart';
import 'package:instagram/utils/gradients.dart';
import 'package:instagram/utils/keyboard.dart';
import 'package:instagram/data/store.dart';

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
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) => _blocListener(context, state),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: darkBackgroundGradient(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 32.0,
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
                        'Dark Instagram',
                        style: TextStyle(
                          fontFamily: 'Billabong',
                          fontSize: 48.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                                  border: OutlineInputBorder(
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
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.blueAccent),
                                  ),
                                  hintText: 'Password'),
                            ),
                          ),
                          SizedBox(
                            height: 32.0,
                          ),
                          RaisedButton(
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
                          SizedBox(
                            height: 64.0,
                          ),
                        ],
                      ),
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
    if (state is ArticleLoadingState) {
      showLoadingDialog(context);
    } else if (state is SignInLoadedState) {
      closeLoadingDialog(context);
      _store.token = state.signInModel;
    } else if (state is SignInErrorState) {
      closeLoadingDialog(context);
      showDialogMessage(context, 'Error', state.message);
    }
  }

  _signInRequest(BuildContext context) {
    closeKeyboard(context);
    _signInBloc.add(FetchSignInEvent(
      _email,
      _password,
    ));
  }
}
