import 'package:flutter/material.dart';

LinearGradient darkBackgroundGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.green[300].withOpacity(.8),
      Colors.indigo[700].withOpacity(.7),
    ],
  );
}
