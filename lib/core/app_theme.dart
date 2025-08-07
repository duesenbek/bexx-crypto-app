import 'package:flutter/material.dart';
final ThemeData appTheme = ThemeData(
  primarySwatch: const MaterialColor(
    0xFF0C4C80,
    <int, Color>{
      50: Color(0xFFE1EAF1),
      100: Color(0xFFB3CADD),
      200: Color(0xFF80A7C7),
      300: Color(0xFF4D84B1),
      400: Color(0xFF2669A1),
      500: Color(0xFF0C4C80),
      600: Color(0xFF0A4473),
      700: Color(0xFF083B64),
      800: Color(0xFF063255),
      900: Color(0xFF03213A),
    },
  ),
  dividerColor: Colors.grey[300],
  iconTheme: const IconThemeData(
    color: Colors.white, // Change the color of the icons
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.grey, // Change the color of the leading icons
    textColor: Colors.black87, // Change the color of the text
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0C4C80), // Change the color of the AppBar
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0, // Change the color of the icons in AppBar
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),

  
  primaryColor: const Color(0xFF0C4C80),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16.0),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14.0),
  ),
);