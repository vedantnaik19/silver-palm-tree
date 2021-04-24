import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static final Color yellowLight = Color(0xFFFCDB7A);
  static final Color yellowELight = Color(0xFFFFF2CC);
  static final Color yellow = Color(0xFFFFBF00);
  static ThemeData getTheme() {
    final ThemeData base = ThemeData.light().copyWith();
    return ThemeData(
      fontFamily: 'Metropolis',
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      accentColor: AppTheme.yellow,
      appBarTheme: base.appBarTheme.copyWith(
        centerTitle: true,
        brightness: Brightness.dark,
        titleSpacing: 0,
        elevation: 0,
      ),
    );
  }
}
