import 'package:flutter/material.dart';

const primaryColor = Color(0xFFF82B10);
final themeData = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  dividerTheme: DividerThemeData(color: Colors.grey.withValues(alpha: 0.1)),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
  ),
);
