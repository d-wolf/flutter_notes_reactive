import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/main.dart';
import 'package:simple_app/presentation/injection_container.dart';
import 'package:simple_app/presentation/note_add/ui/note_add_screen.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_screen.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await init();
  });

  testWidgets('add note to list', (tester) async {
    const expectedNote = Note(
      title: 'title',
      category: 'category',
      content: 'content',
    );

    await tester.pumpWidget(const NotesApp());
    await tester.pumpAndSettle();

    final buttonAddNote =
        find.byKey(const ValueKey(NotesListScreen.buttonAddKey));
    await tester.tap(buttonAddNote);
    await tester.pumpAndSettle();

    final formFieldTitle =
        find.byKey(const ValueKey(NoteAddScreen.formFieldTitleKey));
    await tester.enterText(formFieldTitle, expectedNote.title);
    final formFieldCategory =
        find.byKey(const ValueKey(NoteAddScreen.formFieldCategoryKey));
    await tester.enterText(formFieldCategory, expectedNote.category);
    final formFieldContent =
        find.byKey(const ValueKey(NoteAddScreen.formFieldContentKey));
    await tester.enterText(formFieldContent, expectedNote.content);

    final buttonSaveNote =
        find.byKey(const ValueKey(NoteAddScreen.buttonSaveKey));
    await tester.tap(buttonSaveNote);

    await tester.pumpAndSettle();

    expect(find.text(expectedNote.title), findsOneWidget);
    expect(find.text(expectedNote.category), findsOneWidget);
  });

  testWidgets('switch list view', (tester) async {
    await tester.pumpWidget(const NotesApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(NotesListScreen.itemsListKey)),
        findsOneWidget);

    final switchViewButton =
        find.byKey(const ValueKey(NotesListScreen.buttonSwitchViewKey));

    await tester.tap(switchViewButton);

    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey(NotesListScreen.itemsGridKey)),
        findsOneWidget);
  });
}
