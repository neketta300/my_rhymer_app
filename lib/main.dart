import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_rhymer/api/api.dart';
import 'package:my_rhymer/bloc/cubit/theme_cubit.dart';
import 'package:my_rhymer/features/favorite/bloc/favorite_rhymes_bloc.dart';
import 'package:my_rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:my_rhymer/repositories/favorites/favorite_repository.dart';
import 'package:my_rhymer/repositories/history/history_repository.dart';
import 'package:my_rhymer/repositories/history/models/history_rhymes.dart';
import 'package:my_rhymer/repositories/settings/settings.dart';
import 'package:my_rhymer/router/router.dart';
import 'package:my_rhymer/ui/ui.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/history/bloc/history_rhymes_bloc.dart';
import 'repositories/favorites/models/favorite_rhymes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final config = Configuration.local([
    HistoryRhymes.schema,
    FavoriteRhymes.schema,
  ]);
  final realm = Realm(config);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyRhymerApp(realm: realm, prefs: prefs));
}

void initApplicationDependencies() {}

class MyRhymerApp extends StatefulWidget {
  const MyRhymerApp({super.key, required this.realm, required this.prefs});

  final SharedPreferences prefs;
  final Realm realm;

  @override
  State<MyRhymerApp> createState() => _MyRhymerAppState();
}

class _MyRhymerAppState extends State<MyRhymerApp> {
  // инстенс автороута
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepository(prefs: widget.prefs);
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoriteRepository = FavoriteRepository(realm: widget.realm);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => RhymesListBloc(
                apiClient: RhymeApiClient.create(apiUrl: dotenv.env['API_URL']),
                historyRepository: historyRepository,
                favoriteRepository: favoriteRepository,
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  HistoryRhymesBloc(historyRepository: historyRepository),
        ),
        BlocProvider(
          create:
              (context) => FavoriteRhymesBloc(
                historyRepository: historyRepository,
                favoriteRepository: favoriteRepository,
              ),
        ),
        BlocProvider(
          create:
              (context) => ThemeCubit(settingsRepository: settingsRepository),
        ),
      ],

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'MyRhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
