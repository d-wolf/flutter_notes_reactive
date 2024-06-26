import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:simple_app/main.dart';
import 'package:simple_app/presentation/injection_container.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await init();

  group('end-to-end test', () {
    testWidgets('Add to list', (tester) async {
      await tester.pumpWidget(const NotesApp());
      await tester.pumpAndSettle();

      final fabAddNote = find.byKey(const ValueKey('add'));
      await tester.tap(fabAddNote);
      await tester.pumpAndSettle();

      final formFieldTitle = find.byKey(const ValueKey('form_field_title'));
      await tester.enterText(formFieldTitle, 'title');
      final formFieldCategory =
          find.byKey(const ValueKey('form_field_category'));
      await tester.enterText(formFieldCategory, 'Category');
      final formFieldContent = find.byKey(const ValueKey('form_field_content'));
      await tester.enterText(formFieldContent, 'Content');

      final fabSaveNote = find.byKey(const ValueKey('save'));
      await tester.tap(fabSaveNote);

      await tester.pumpAndSettle();

      expect(find.text('title'), findsOneWidget);
    });
  });
}
