import 'package:simple_app/data/settings/settings_data_source.dart';
import 'package:simple_app/domain/settings/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource _source;

  SettingsRepositoryImpl({required SettingsDataSource source})
      : _source = source;

  @override
  Stream<bool> isListViewStream() => _source.isListViewStream();

  @override
  Future<void> setIsListView(bool value) => _source.setIsListView(value);
}
