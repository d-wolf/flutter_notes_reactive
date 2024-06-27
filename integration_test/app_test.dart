import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:simple_app/main.dart';
import 'package:simple_app/presentation/injection_container.dart';
import 'package:simple_app/presentation/note_add/ui/note_add_screen.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_screen.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await init();

  group('end-to-end test', () {
    testWidgets('Add to list', (tester) async {
      await tester.pumpWidget(const NotesApp());
      await tester.pumpAndSettle();

      final fabAddNote = find.byKey(const ValueKey(NotesListScreen.addKey));
      await tester.tap(fabAddNote);
      await tester.pumpAndSettle();

      final formFieldTitle =
          find.byKey(const ValueKey(NoteAddScreen.formFieldTitleKey));
      await tester.enterText(formFieldTitle, 'title');
      final formFieldCategory =
          find.byKey(const ValueKey(NoteAddScreen.formFieldCategoryKey));
      await tester.enterText(formFieldCategory, 'Category');
      final formFieldContent =
          find.byKey(const ValueKey(NoteAddScreen.formFieldContentKey));
      await tester.enterText(formFieldContent, 'Content');

      final fabSaveNote = find.byKey(const ValueKey(NoteAddScreen.saveKey));
      await tester.tap(fabSaveNote);

      await tester.pumpAndSettle();

      expect(find.text('title'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
    });
  });
}
