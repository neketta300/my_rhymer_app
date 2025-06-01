import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFF82B10);
final themeData = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
  ),
  textTheme: _textTheme,
  useMaterial3: true,
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: Colors.black,
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
  ),
  dividerTheme: DividerThemeData(color: Colors.grey.withValues(alpha: 0.1)),
  textTheme: _textTheme,
  useMaterial3: true,
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
);

final _textTheme = const TextTheme(
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
);

extension ThemePlatformExtensio on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  Color get cupertinoAlertColor => _primaryColor;
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}
