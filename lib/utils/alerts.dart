import 'package:flutter/material.dart';

Future<void> showDialogMessage(
  BuildContext context,
  String title,
  String message,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showLoadingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              Text("Loading"),
            ],
          ),
        ),
      );
    },
  );
}

closeLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
