import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defaultColor = Colors.blue;
const MaterialColor primarySwatchLight = Colors.blue;
const Color white = Colors.white;
const Color black = Colors.black;

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primarySwatch: primarySwatchLight,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: black,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primarySwatchLight,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primarySwatchLight,
    elevation: 20.0,
    backgroundColor: white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: black,
    ),
  ),
);

TextStyle selectedAns = const TextStyle(
    color: Colors.red, fontSize: 15, fontWeight: FontWeight.w900);
TextStyle numberDraw = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
