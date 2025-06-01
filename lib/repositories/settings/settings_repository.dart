import 'package:my_rhymer/repositories/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryI {
  SettingsRepository({required this.prefs});
  final SharedPreferences prefs;
  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final selected = prefs.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await prefs.setBool(_isDarkThemeSelectedKey, selected);
  }
}
