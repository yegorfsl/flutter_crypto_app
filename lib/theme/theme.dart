import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold
      )
  ),
  scaffoldBackgroundColor: Colors.grey,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      labelSmall: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14
      )
  ),
  // useMaterial3: true,
);