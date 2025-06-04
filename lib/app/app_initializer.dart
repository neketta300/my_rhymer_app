import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_rhymer/api/rhymes_api.dart';
import 'package:my_rhymer/bloc/cubit/theme_cubit.dart';
import 'package:my_rhymer/features/favorite/bloc/favorite_rhymes_bloc.dart';
import 'package:my_rhymer/features/search/bloc/rhymes_list_bloc.dart';
import 'package:my_rhymer/repositories/settings/settings.dart';

import '../features/history/bloc/history_rhymes_bloc.dart';
import '../repositories/favorites/favorites.dart';
import '../repositories/history/history.dart';
import 'app_config.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({
    super.key,
    required this.child,
    required this.appConfig,
  });

  final AppConfig appConfig;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepositoryI>(
          create:
              (context) =>
                  SettingsRepository(prefs: appConfig.sharedPreferences),
        ),
        RepositoryProvider<HistoryRepositoryI>(
          create: (context) => HistoryRepository(realm: appConfig.realm),
        ),
        RepositoryProvider<FavoriteRepositoryI>(
          create: (context) => FavoriteRepository(realm: appConfig.realm),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => RhymesListBloc(
                  apiClient: RhymeApiClient.create(
                    apiUrl: dotenv.env['API_URL'],
                  ),
                  historyRepository: context.read<HistoryRepositoryI>(),
                  favoriteRepository: context.read<FavoriteRepositoryI>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => HistoryRhymesBloc(
                  historyRepository: context.read<HistoryRepositoryI>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => FavoriteRhymesBloc(
                  historyRepository: context.read<HistoryRepositoryI>(),
                  favoriteRepository: context.read<FavoriteRepositoryI>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => ThemeCubit(
                  settingsRepository: context.read<SettingsRepositoryI>(),
                ),
          ),
        ],

        child: child,
      ),
    );
  }
}
