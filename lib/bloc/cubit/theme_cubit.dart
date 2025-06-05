import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_rhymer/repositories/settings/settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required SettingsRepositoryI settingsRepository,
    required Talker talker,
  }) : _settingsRepository = settingsRepository,
       _talker = talker,
       super(const ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final SettingsRepositoryI _settingsRepository;
  final Talker _talker;

  Future<void> setThemeBrightness(Brightness brightness) async {
    try {
      emit(ThemeState(brightness));
      await _settingsRepository.setDarkThemeSelected(
        brightness == Brightness.dark,
      );
    } catch (e, st) {
      _talker.handle(e, st);
    }
  }

  void _checkSelectedTheme() {
    try {
      final brightness =
          _settingsRepository.isDarkThemeSelected()
              ? Brightness.dark
              : Brightness.light;
      emit(ThemeState(brightness));
    } catch (e, st) {
      _talker.handle(e, st);
    }
  }
}
