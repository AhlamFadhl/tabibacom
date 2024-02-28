import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabibacom_doctor/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.black),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: progressColor),
  colorScheme: ThemeData().colorScheme.copyWith(primary: primaryColor),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: progressColor, linearMinHeight: 2),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: primaryColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Almarai'),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 10.0,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Almarai',
);
