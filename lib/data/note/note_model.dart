import 'package:drift/drift.dart';
import 'package:simple_app/data/database/app_database.dart';
import 'package:simple_app/domain/note/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.category,
    required super.content,
  });

  NoteModel.from(Note note)
      : this(
          id: note.id,
          title: note.title,
          category: note.category,
          content: note.content,
        );

  NotesTableCompanion toCompanion() {
    return NotesTableCompanion(
      id: Value.absentIfNull(id),
      title: Value(title),
      category: Value(category),
      content: Value(content),
    );
  }
}
