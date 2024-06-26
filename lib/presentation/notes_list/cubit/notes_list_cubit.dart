import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

part 'notes_list_state.dart';

class NotesListCubit extends Cubit<NotesListState> {
  final NotesRepository _notesRepository;
  StreamSubscription<List<Note>>? _sub;

  NotesListCubit({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(const NotesListLoading()) {
    _sub = _notesRepository.getNotesStream().listen((notes) {
      emit(NotesListUpdate(notes: notes));
    });
  }

  Future<void> onDelete(Note note) async {
    await _notesRepository.deleteNote(note);
  }

  @override
  Future<void> close() async {
    await super.close();
    _sub?.cancel();
  }
}
