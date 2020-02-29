import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_bloc.dart';
import 'package:instagram/bloc/sign_up/sign_up_bloc.dart';
import 'package:instagram/data/repositories/auth_repository.dart';
import 'package:instagram/ui/pages/sign_in_page.dart';
import 'package:instagram/ui/pages/sign_up_page.dart';
import 'package:instagram/utils/gradients.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: darkBackgroundGradient(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(
                    child: ImageIcon(
                      AssetImage('assets/images/instagram.png'),
                      size: 100.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Instagram',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 48.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.purple[700],
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        onPressed: () => _navigateToSignInPage(context),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      RaisedButton(
                        color: Colors.deepPurple[600],
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        onPressed: () => _navigateToSignUpPage(context),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSignInPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider(
          child: SignInPage(),
          create: (BuildContext context) {
            return SignInBloc(repository: AuthRepositoryImpl());
          },
        );
      }),
    );
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        child: SignUpPage(),
        create: (BuildContext context) {
          return SignUpBloc(repository: AuthRepositoryImpl());
        },
      );
    }));
  }
}
