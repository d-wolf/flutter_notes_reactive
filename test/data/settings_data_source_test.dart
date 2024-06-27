import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:simple_app/data/settings/settings_data_source.dart';

class MockRxSharedPreferences extends Mock implements RxSharedPreferences {}

void main() {
  late SettingsDataSource source;
  late MockRxSharedPreferences prefs;

  setUp(() {
    prefs = MockRxSharedPreferences();
    source = SettingsDataSource(prefs: prefs);
  });

  test('isListViewStream emits default true', () async {
    final controller = StreamController<bool?>();
    when(() => prefs.getBoolStream(any())).thenAnswer((_) => controller.stream);
    controller.add(null);
    expect(source.isListViewStream(), emits(true));
  });

  test('isListViewStream emits changes', () async {
    final controller = StreamController<bool?>();
    when(() => prefs.getBoolStream(any())).thenAnswer((_) => controller.stream);
    controller.add(null);
    controller.add(false);
    controller.add(true);
    expect(source.isListViewStream(), emitsInOrder([true, false, true]));
  });
}
