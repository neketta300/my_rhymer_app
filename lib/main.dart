import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_rhymer/api/api.dart';
import 'package:my_rhymer/features/favorite/bloc/favorite_rhymes_bloc.dart';
import 'package:my_rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:my_rhymer/repositories/favorites/favorite_repository.dart';
import 'package:my_rhymer/repositories/history/history_repository.dart';
import 'package:my_rhymer/repositories/history/models/history_rhymes.dart';
import 'package:my_rhymer/router/router.dart';
import 'package:my_rhymer/ui/ui.dart';
import 'package:realm/realm.dart';

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
  runApp(MyRhymerApp(realm: realm));
}

void initApplicationDependencies() {}

class MyRhymerApp extends StatefulWidget {
  const MyRhymerApp({super.key, required this.realm});

  final Realm realm;

  @override
  State<MyRhymerApp> createState() => _MyRhymerAppState();
}

class _MyRhymerAppState extends State<MyRhymerApp> {
  // инстенс автороута
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
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
      ],

      child: MaterialApp.router(
        title: 'MyRhymer',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
