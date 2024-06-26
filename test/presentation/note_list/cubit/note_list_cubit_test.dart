import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late MockNotesRepository repository;
  late StreamController<List<Note>> getNotesStreamController;

  setUp(() {
    registerFallbackValue(const Note(
      id: 1,
      title: '',
      category: '',
      content: '',
    ));

    repository = MockNotesRepository();
    getNotesStreamController = StreamController<List<Note>>();
  });

  blocTest(
    'emits NotesListUpdate with empty list',
    setUp: () {
      when(repository.getNotesStream)
          .thenAnswer((_) => getNotesStreamController.stream);

      getNotesStreamController.add([]);
    },
    build: () => NotesListCubit(notesRepository: repository),
    expect: () => [const NotesListUpdate(notes: [])],
  );

  blocTest(
    'emits NotesListUpdate with item',
    setUp: () {
      when(repository.getNotesStream)
          .thenAnswer((_) => getNotesStreamController.stream);

      getNotesStreamController.add([
        const Note(
          id: 1,
          title: 'title',
          category: 'category',
          content: 'content',
        )
      ]);
    },
    build: () => NotesListCubit(notesRepository: repository),
    expect: () => [
      const NotesListUpdate(notes: [
        Note(
          id: 1,
          title: 'title',
          category: 'category',
          content: 'content',
        )
      ])
    ],
  );

  test('delete note called', () async {
    const note =
        Note(id: 1, title: 'title', category: 'category', content: 'content');
    when(repository.getNotesStream)
        .thenAnswer((_) => getNotesStreamController.stream);
    when(() => repository.deleteNote(any())).thenAnswer((_) => Future.value(1));
    getNotesStreamController.add([note]);

    final cubit = NotesListCubit(notesRepository: repository);

    await cubit.onDelete(note);

    verify(() => repository.deleteNote(any())).called(1);
  });
}
