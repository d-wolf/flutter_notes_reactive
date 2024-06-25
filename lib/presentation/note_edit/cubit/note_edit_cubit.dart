import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

part 'note_edit_state.dart';

class NoteEditCubit extends Cubit<NoteEditState> {
  final NotesRepository _notesRepository;

  NoteEditCubit({required Note note, required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(NoteEditUpdate(note: note)) {
    _notesRepository.getNoteStream(note.id!).listen((note) {
      if (note != null) {
        emit(NoteEditUpdate(note: note));
      }
    });
  }

  void onUpdate(Note note) {
    _notesRepository.updateNote(note);
  }
}
