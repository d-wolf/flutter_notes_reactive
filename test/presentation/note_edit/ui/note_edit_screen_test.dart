import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_edit/cubit/note_edit_cubit.dart';
import 'package:simple_app/presentation/note_edit/ui/note_edit_screen.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class MockNoteEditCubit extends MockCubit<NoteEditState>
    implements NoteEditCubit {}

void main() {
  var eNote = const Note(
      id: 1, title: 'title', category: 'category', content: 'content');

  testWidgets('add update pressed', (WidgetTester tester) async {
    final cubit = MockNoteEditCubit();
    when(() => cubit.state).thenReturn(NoteEditUpdate(note: eNote));
    when(() => cubit.onUpdate(any(), any(), any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(MaterialApp(
        home: BlocProvider<NoteEditCubit>.value(
      value: cubit,
      child: Builder(builder: (context) {
        return const NoteEditScreen();
      }),
    )));

    await tester.pumpAndSettle();
    final save = find.byKey(const ValueKey(NoteEditScreen.buttonUpdateKey));
    await tester.tap(save);
    verify(() => cubit.onUpdate(any(), any(), any())).called(1);
  });

  testWidgets('displays selected', (WidgetTester tester) async {
    final cubit = MockNoteEditCubit();

    var stateUpdate = NoteEditUpdate(note: eNote);

    when(() => cubit.state).thenReturn(stateUpdate);
    when(() => cubit.onUpdate(any(), any(), any()))
        .thenAnswer((_) => Future.value());

    // https://github.com/felangel/bloc/issues/655
    whenListen(
        cubit,
        Stream.fromIterable([
          stateUpdate,
        ]));

    await tester.pumpWidget(MaterialApp(
        home: BlocProvider<NoteEditCubit>.value(
      value: cubit,
      child: Builder(builder: (context) {
        return const NoteEditScreen();
      }),
    )));

    await tester.pumpAndSettle(Durations.extralong4);

    expect(find.text('category'), findsOneWidget);
    expect(find.text('content'), findsOneWidget);
  });
}
