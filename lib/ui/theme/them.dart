import 'package:flutter/material.dart';

final primaryColor = const Color(0xFFF82B10);
final themData = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);
