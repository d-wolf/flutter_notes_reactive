import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/domain/settings/settings_repository.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  var eNote = const Note(
      id: 1, title: 'title', category: 'category', content: 'content');

  late MockNotesRepository notesRepository;
  late MockSettingsRepository settingsRepository;
  late StreamController<List<Note>> getNotesStreamController;
  late StreamController<bool> getIsListViewStreamController;

  setUp(() {
    registerFallbackValue(eNote);

    notesRepository = MockNotesRepository();
    settingsRepository = MockSettingsRepository();
    getNotesStreamController = StreamController();
    getIsListViewStreamController = StreamController();
  });

  blocTest(
    'emits NotesListUpdate with empty list',
    setUp: () {
      when(notesRepository.getNotesStream)
          .thenAnswer((_) => getNotesStreamController.stream);
      when(settingsRepository.isListViewStream)
          .thenAnswer((_) => getIsListViewStreamController.stream);

      getNotesStreamController.add([]);
      getIsListViewStreamController.add(true);
    },
    build: () => NotesListCubit(
        notesRepository: notesRepository,
        settingsRepository: settingsRepository),
    expect: () => [const NotesListUpdate(notes: [], isListView: true)],
  );

  blocTest(
    'emits NotesListUpdate with item',
    setUp: () {
      when(notesRepository.getNotesStream)
          .thenAnswer((_) => getNotesStreamController.stream);
      when(settingsRepository.isListViewStream)
          .thenAnswer((_) => getIsListViewStreamController.stream);

      getNotesStreamController.add([eNote]);
      getIsListViewStreamController.add(true);
    },
    build: () => NotesListCubit(
      notesRepository: notesRepository,
      settingsRepository: settingsRepository,
    ),
    expect: () => [
      NotesListUpdate(notes: [eNote], isListView: true)
    ],
  );

  test('delete note called', () async {
    when(notesRepository.getNotesStream)
        .thenAnswer((_) => getNotesStreamController.stream);
    when(() => notesRepository.deleteNote(any()))
        .thenAnswer((_) => Future.value(1));
    when(settingsRepository.isListViewStream)
        .thenAnswer((_) => getIsListViewStreamController.stream);

    getNotesStreamController.add([eNote]);
    getIsListViewStreamController.add(true);

    final cubit = NotesListCubit(
      notesRepository: notesRepository,
      settingsRepository: settingsRepository,
    );

    await cubit.onDelete(eNote);

    verify(() => notesRepository.deleteNote(any())).called(1);
  });
}
