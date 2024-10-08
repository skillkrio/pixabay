import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      fontFamily: 'lato',
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      brightness: Brightness.light);
}
