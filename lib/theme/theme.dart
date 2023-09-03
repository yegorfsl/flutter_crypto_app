import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  // Global settings
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  // App Theme
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.yellow,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(color: Colors.black)
  ),
  // List Tile Theme
  listTileTheme: const ListTileThemeData(iconColor: Colors.black),
  // Text Theme
  textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      labelSmall: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14
      )
  ),
);