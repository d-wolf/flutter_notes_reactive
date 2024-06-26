import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_screen.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late MockNotesRepository repository;
  final getNotesStreamController = StreamController<List<Note>>();

  setUp(() {
    repository = MockNotesRepository();
    when(repository.getNotesStream)
        .thenAnswer((_) => getNotesStreamController.stream);
  });

  testWidgets('display notes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (_) => NotesListCubit(notesRepository: repository),
      child: Builder(builder: (context) {
        return const NotesListScreen();
      }),
    )));

    getNotesStreamController.add([
      const Note(title: 'title', category: 'category', content: 'content'),
    ]);

    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
  });
}
