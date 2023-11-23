import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

MaterialColor customColorOrange = const MaterialColor(0xFFFF3C38, {
  50: Color(0xffffeceb),
  100: Color(0xffffd8d7),
  200: Color(0xffffc5c3),
  300: Color(0xffffb1af),
  400: Color(0xffff9e9c),
  500: Color(0xffff8a88),
  600: Color(0xffff7774),
  700: Color(0xffff6360),
  800: Color(0xffff504c),
  900: Color(0xffff3c38),
});
MaterialColor customColorBlue = const MaterialColor(0xFF74c2ed, {
  50: Color(0xFFe5f1fa),
  100: Color(0xFFb3d9f2),
  200: Color(0xFF80c1ea),
  300: Color(0xFF4ea9e2),
  400: Color(0xFF1c91da),
  500: Color(0xFF0079d2),
  600: Color(0xFF0065a8),
  700: Color(0xFF00527e),
  800: Color(0xFF003f54),
  900: Color(0xFF002d2a),
});


ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 30,
    backgroundColor: MyColors.whiteColor,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyColors.orangeColor,
    unselectedItemColor: MyColors.blueColor,
    selectedLabelStyle: TextStyle(fontFamily: 'bebas'),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: MyColors.fire),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColors.whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: MyColors.whiteColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(color: MyColors.blackColor),
  ),
  scaffoldBackgroundColor: MyColors.whiteColor,
  primarySwatch: customColorOrange,
  textTheme: TextTheme(
    bodyMedium:
        const TextStyle(color: MyColors.blackColor, fontFamily: 'bitter-bold'),
    bodySmall: TextStyle(
        color: MyColors.blackColor.withOpacity(0.5), fontFamily: 'bitter'),
  ),
    inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: MyColors.blackColor,
        suffixIconColor: MyColors.blackColor,
        labelStyle: TextStyle(color: MyColors.blackColor),
    )
);
ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 30,
      backgroundColor: MyColors.blackColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.fire,
      unselectedItemColor: MyColors.blueColor,
      selectedLabelStyle: TextStyle(fontFamily: 'bebas'),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: MyColors.whiteColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: MyColors.blueColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: MyColors.blueColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: MyColors.whiteColor),
    ),
    scaffoldBackgroundColor: MyColors.blueColor,
    primarySwatch: customColorBlue,
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: MyColors.whiteColor, fontFamily: 'bitter-bold'),
      bodySmall: TextStyle(
          color: MyColors.blueColor.withOpacity(0.5), fontFamily: 'bitter'),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: MyColors.blueColor,
        suffixIconColor: MyColors.blueColor,
        labelStyle: TextStyle(color: MyColors.blueColor)));
