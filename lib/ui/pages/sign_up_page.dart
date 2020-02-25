import 'package:flutter/material.dart';
import 'package:instagram/ui/widgets/gradients.dart';

class SignUpPage extends StatelessWidget {
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
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
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeFirstName,
                            onFieldSubmitted: (term) {
                              _focusNodeFirstName.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeLastName);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
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
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeLastName,
                            onFieldSubmitted: (term) {
                              _focusNodeLastName.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeEmail);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
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
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodeEmail,
                            onFieldSubmitted: (term) {
                              _focusNodeEmail.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusNodePassword);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
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
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.center,
                            focusNode: _focusNodePassword,
                            onFieldSubmitted: (term) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
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
                              "Sign Up",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          onPressed: () {},
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
    );
  }
}
