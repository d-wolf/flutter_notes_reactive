import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_add/cubit/note_add_cubit.dart';
import 'package:simple_app/presentation/note_add/ui/note_add_screen.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class MockNoteAddCubit extends MockCubit<NoteAddState>
    implements NoteAddCubit {}

void main() {
  testWidgets('add note pressed', (WidgetTester tester) async {
    final cubit = MockNoteAddCubit();
    when(() => cubit.state).thenReturn(const NoteAddUpdate());
    when(() => cubit.onAdd(any(), any(), any()))
        .thenAnswer((_) => Future.value());

    await tester.pumpWidget(MaterialApp(
        home: BlocProvider<NoteAddCubit>.value(
      value: cubit,
      child: Builder(builder: (context) {
        return const NoteAddScreen();
      }),
    )));

    await tester.pumpAndSettle();
    final save = find.byKey(const ValueKey(NoteAddScreen.saveKey));
    await tester.tap(save);
    verify(() => cubit.onAdd(any(), any(), any())).called(1);
  });
}
