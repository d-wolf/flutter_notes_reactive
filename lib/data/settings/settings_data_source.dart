import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class SettingsDataSource {
  final RxSharedPreferences _rxPrefs;

  static const isListViewKey = 'IS_LIST_VIEW';

  SettingsDataSource({required RxSharedPreferences prefs}) : _rxPrefs = prefs;

  Stream<bool> isListViewStream() =>
      _rxPrefs.getBoolStream(isListViewKey).map((event) => event ?? true);

  Future<void> setIsListView(bool value) =>
      _rxPrefs.setBool(isListViewKey, value);
}
