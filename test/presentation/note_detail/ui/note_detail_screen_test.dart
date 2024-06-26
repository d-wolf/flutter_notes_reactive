import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';
import 'package:simple_app/presentation/note_detail/ui/note_detail_screen.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late MockNotesRepository repository;
  final getNoteStreamController = StreamController<Note>();

  setUp(() {
    repository = MockNotesRepository();
    when(() => repository.getNoteStream(any()))
        .thenAnswer((_) => getNoteStreamController.stream);
  });

  testWidgets('display note', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: BlocProvider(
      create: (_) => NoteDetailCubit(noteId: 1, notesRepository: repository),
      child: Builder(builder: (context) {
        return const NoteDetailScreen();
      }),
    )));

    getNoteStreamController.add(const Note(
        id: 1, title: 'title', category: 'category', content: 'content'));

    await tester.pumpAndSettle();

    expect(find.text('title'), findsOneWidget);
    expect(find.text('category'), findsOneWidget);
    expect(find.text('content'), findsOneWidget);
  });
}
