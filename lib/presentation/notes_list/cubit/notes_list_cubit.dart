import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/domain/settings/settings_repository.dart';

part 'notes_list_state.dart';

class NotesListCubit extends Cubit<NotesListState> {
  final NotesRepository _notesRepository;
  final SettingsRepository _settingsRepository;

  StreamSubscription<NotesListUpdate>? _sub;

  NotesListCubit({
    required NotesRepository notesRepository,
    required SettingsRepository settingsRepository,
  })  : _notesRepository = notesRepository,
        _settingsRepository = settingsRepository,
        super(const NotesListLoading()) {
    _sub = CombineLatestStream.combine2(
        _notesRepository.getNotesStream(),
        _settingsRepository.isListViewStream(),
        (notes, isListView) =>
            NotesListUpdate(notes: notes, isListView: isListView)).listen(emit);
  }

  Future<void> onDelete(Note note) async {
    await _notesRepository.deleteNote(note);
  }

  Future<void> onSwitchLayout() async {
    switch (state) {
      case NotesListUpdate update:
        await _settingsRepository.setIsListView(!update.isListView);
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
