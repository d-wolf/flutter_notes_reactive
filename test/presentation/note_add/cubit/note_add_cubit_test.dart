import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/note_add/cubit/note_add_cubit.dart';

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
    registerFallbackValue(eNote);
    repository = MockNotesRepository();
  });

  test('delete note called', () async {
    when(() => repository.insertNote(any())).thenAnswer((_) => Future.value(1));
    final cubit = NoteAddCubit(notesRepository: repository);

    await cubit.onAdd(eNote.title, eNote.category, eNote.content);

    verify(() => repository.insertNote(any())).called(1);
  });
}
