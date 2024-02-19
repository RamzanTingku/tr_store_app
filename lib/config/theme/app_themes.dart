import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme()
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: ColorUtils.primaryColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  );
}

ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ColorUtils.primaryColor));