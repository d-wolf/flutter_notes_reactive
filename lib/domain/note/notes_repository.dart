import 'note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Stream<List<Note>> getNotesStream();
  Future<Note?> getNote(int id);
  Stream<Note?> getNoteStream(int id);
  Future<int> insertNote(Note entity);
  Future<bool> updateNote(Note entity);
  Future<int> deleteNote(Note entity);
  Future<int> deleteNotes();
}
