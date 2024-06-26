import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

part 'note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  final NotesRepository _notesRepository;

  StreamSubscription<Note?>? _sub;

  NoteDetailCubit(
      {required int noteId, required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(const NoteDetailLoading()) {
    _sub = _notesRepository.getNoteStream(noteId).listen((note) {
      if (note != null && !isClosed) {
        emit(NoteDetailUpdate(note: note));
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
    await _sub?.cancel();
  }
}
