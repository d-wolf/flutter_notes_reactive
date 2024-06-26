import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';

part 'note_add_state.dart';

class NoteAddCubit extends Cubit<NoteAddState> {
  final NotesRepository _notesRepository;

  NoteAddCubit({required NotesRepository notesRepository})
      : _notesRepository = notesRepository,
        super(const NoteAddUpdate());

  Future<void> onAdd(String title, String category, String content) async {
    switch (state) {
      case NoteAddUpdate _:
        emit(const NoteAddLoading());
        await _notesRepository.insertNote(
            Note(title: title, category: category, content: content));
        emit(const NoteAddSuccess());
        break;
      default:
    }
  }
}
