import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,

    primaryColor: const Color(0xff9cc33a),
    hintColor: Colors.cyan[600],
    scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),

    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white),
    ),
    // Add other customizations as needed
  );
}
