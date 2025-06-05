import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/bloc/cubit/theme_cubit.dart';
import 'package:my_rhymer/router/router.dart';
import 'package:my_rhymer/ui/ui.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app.dart';

class MyRhymerApp extends StatefulWidget {
  const MyRhymerApp({super.key, required this.appConfig});

  final AppConfig appConfig;

  @override
  State<MyRhymerApp> createState() => _MyRhymerAppState();
}

class _MyRhymerAppState extends State<MyRhymerApp> {
  // инстенс автороута
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      appConfig: widget.appConfig,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final talker = context.read<Talker>();

          return MaterialApp.router(
            title: 'MyRhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(
              navigatorObservers: () => [TalkerRouteObserver(talker)],
            ),
          );
        },
      ),
    );
  }
}
