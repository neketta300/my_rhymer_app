import 'package:flutter/material.dart';

final primaryColor = const Color(0xFFF82B10);
final themData = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.white),
  dividerTheme: DividerThemeData(color: Colors.grey.withValues(alpha: 0.1)),
  // scaffoldBackgroundColor: Colors.white,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
