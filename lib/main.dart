import 'package:flutter/material.dart';
import 'package:my_rhymer/router/router.dart';

void main() {
  runApp(const MyRhymerApp());
}

class MyRhymerApp extends StatefulWidget {
  const MyRhymerApp({super.key});

  @override
  State<MyRhymerApp> createState() => _MyRhymerAppState();
}

class _MyRhymerAppState extends State<MyRhymerApp> {
  // инстенс автороута
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFF82B10);
    return MaterialApp.router(
      title: 'MyRhymer',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFF1F3),
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      routerConfig: _router.config(),
    );
  }
}
