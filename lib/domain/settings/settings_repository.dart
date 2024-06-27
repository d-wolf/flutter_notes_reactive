abstract class SettingsRepository {
  Stream<bool> isListViewStream();
  Future<void> setIsListView(bool value);
}
