import 'package:flutter/material.dart';
import 'package:my_rhymer/router/router.dart';
import 'package:my_rhymer/ui/ui.dart';

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
    return MaterialApp.router(
      title: 'MyRhymer',
      theme: themData,
      routerConfig: _router.config(),
    );
  }
}
