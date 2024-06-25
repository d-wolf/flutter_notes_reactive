import 'package:simple_app/data/note/notes_dao.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesDao _dao;

  NotesRepositoryImpl({required NotesDao dao}) : _dao = dao;

  @override
  Future<int> deleteNote(Note entity) async {
    return await _dao.deleteNote(entity);
  }

  @override
  Future<int> deleteNotes() async {
    return await _dao.deleteNotes();
  }

  @override
  Future<Note?> getNote(int id) async {
    return await _dao.getNote(id);
  }

  @override
  Stream<Note?> getNoteStream(int id) {
    return _dao.getNoteStream(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return _dao.getNotes();
  }

  @override
  Stream<List<Note>> getNotesStream() {
    return _dao.getNotesStream();
  }

  @override
  Future<int> insertNote(Note entity) async {
    return _dao.insertNote(entity);
  }

  @override
  Future<bool> updateNote(Note entity) async {
    return _dao.updateNote(entity);
  }
}
