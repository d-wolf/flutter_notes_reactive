import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_edit/cubit/note_edit_cubit.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  var eNote = const Note(
    id: 1,
    title: 'titleString',
    category: 'categoryString',
    content: 'contentString',
  );

  late MockNotesRepository repository;

  setUp(() {
    repository = MockNotesRepository();
  });

  blocTest(
    'emits NoteDetailUpdate with note',
    setUp: () {
      final getNoteStreamController = StreamController<Note>();
      when(() => repository.getNoteStream(any()))
          .thenAnswer((_) => getNoteStreamController.stream);
      getNoteStreamController.add(eNote);
    },
    build: () {
      return NoteEditCubit(noteId: 1, notesRepository: repository);
    },
    expect: () => [
      NoteEditUpdate(note: eNote),
    ],
  );
}
