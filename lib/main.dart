import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_rhymer/api/api.dart';
import 'package:my_rhymer/router/router.dart';
import 'package:my_rhymer/ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final client = RhymeApiClient.create(apiUrl: dotenv.env['API_URL']);
  runApp(const MyRhymerApp());
}

void initApplicationDependencies() {}

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
