import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

part 'note_edit_state.dart';

class NoteEditCubit extends Cubit<NoteEditState> {
  final NotesRepository _notesRepository;

  StreamSubscription<Note?>? _sub;

  NoteEditCubit({required int noteId, required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(const NoteEditLoading()) {
    _sub = _notesRepository.getNoteStream(noteId).listen((note) {
      if (note != null && !isClosed) {
        emit(NoteEditUpdate(note: note));
      }
    });
  }

  Future<void> onUpdate(String title, String category, String content) async {
    switch (state) {
      case NoteEditUpdate update:
        await _notesRepository.updateNote(Note(
            id: update.note.id,
            title: title,
            category: category,
            content: content));
        break;
      default:
    }
  }

  @override
  Future<void> close() async {
    await super.close();
    await _sub?.cancel();
  }
}
