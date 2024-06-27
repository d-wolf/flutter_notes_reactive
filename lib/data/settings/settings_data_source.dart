import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class SettingsDataSource {
  final RxSharedPreferences _rxPrefs;

  SettingsDataSource({required SharedPreferences prefs})
      : _rxPrefs = RxSharedPreferences(prefs);

  Stream<bool> isListViewStream() => _rxPrefs.getBoolStream('IS_LIST_VIEW').map(
        (event) => event ?? true,
      );

  Future<void> setIsListView(bool value) =>
      _rxPrefs.setBool('IS_LIST_VIEW', value);
}
