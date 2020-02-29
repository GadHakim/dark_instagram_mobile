import 'package:flutter/material.dart';

Color _gradientStart = Colors.deepPurple[700];
Color _gradientEnd = Colors.purple[500];

LinearGradient darkBackgroundGradient() {
  return LinearGradient(colors: [_gradientStart, _gradientEnd],
      begin: const FractionalOffset(0.5, 0.0),
      end: const FractionalOffset(0.0, 0.5),
      stops: [0.0,1.0],
      tileMode: TileMode.clamp
  );
}
