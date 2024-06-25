import 'package:drift/drift.dart';
import 'package:simple_app/data/note/notes_table.dart';
import 'package:simple_app/data/note/note_model.dart';
import 'package:simple_app/domain/note/note.dart';

import '../database/app_database.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [NotesTable])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  final AppDatabase db;

  NotesDao(this.db) : super(db);

  Future<List<Note>> getNotes() => select(notesTable).get();

  Stream<List<Note>> getNotesStream() => select(notesTable).watch();

  Future<Note?> getNote(int id) =>
      (select(notesTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<Note?> getNoteStream(int id) =>
      (select(notesTable)..where((t) => t.id.equals(id))).watchSingle();

  Future<int> insertNote(Note entity) =>
      into(notesTable).insert(NoteModel.from(entity).toCompanion());

  Future<bool> updateNote(Note entity) =>
      update(notesTable).replace(NoteModel.from(entity).toCompanion());

  Future<int> deleteNote(Note entity) =>
      delete(notesTable).delete(NoteModel.from(entity).toCompanion());

  Future<int> deleteNotes() => delete(notesTable).go();
}
