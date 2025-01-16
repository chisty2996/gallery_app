import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData theme(){
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      primaryContainer: Colors.black,
      secondary: CustomColors.mintGreen,
    ),
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: CustomColors.paleWhite,
        fontSize: 12,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.bold
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 20
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        color: CustomColors.greyWhite,
        fontSize: 14
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold
      )
    ),
    scaffoldBackgroundColor: Colors.white
  );
}