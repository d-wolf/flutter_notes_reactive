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

  final notesStreamController = StreamController<List<Note>>();

  setUp(() {
    repository = MockNotesRepository();
  });

  blocTest(
    'emits NotesListUpdate with empty list',
    build: () {
      when(repository.getNotesStream)
          .thenAnswer((_) => notesStreamController.stream);
      return NotesListCubit(notesRepository: repository);
    },
    act: (bloc) {
      notesStreamController.add([]);
    },
    expect: () => [const NotesListUpdate(notes: [])],
  );
}
