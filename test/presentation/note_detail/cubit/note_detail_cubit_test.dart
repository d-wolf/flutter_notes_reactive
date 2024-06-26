import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late MockNotesRepository repository;
  late StreamController<Note> getNoteStreamController;

  setUp(() {
    repository = MockNotesRepository();
    getNoteStreamController = StreamController<Note>();
    when(() => repository.getNoteStream(any()))
        .thenAnswer((_) => getNoteStreamController.stream);
  });

  blocTest(
    'emits NoteDetailUpdate with note',
    build: () {
      return NoteDetailCubit(noteId: 1, notesRepository: repository);
    },
    act: (bloc) {
      getNoteStreamController
          .add(const Note(id: 1, title: '', category: '', content: ''));
    },
    expect: () => [
      const NoteDetailUpdate(
          note: Note(id: 1, title: '', category: '', content: ''))
    ],
  );
}
