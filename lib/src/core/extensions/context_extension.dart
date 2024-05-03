import 'package:flutter/material.dart';

///Extension to get screen size (syntactic sugar)
extension Screen on BuildContext {
  ///Get screen height by use [MediaQuery.of]
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ///Get screen width by use [MediaQuery.of]
  double get screenWidth => MediaQuery.sizeOf(this).width;

  ///Get theme by use [Theme.of]
  ThemeData get theme => Theme.of(this);
}
