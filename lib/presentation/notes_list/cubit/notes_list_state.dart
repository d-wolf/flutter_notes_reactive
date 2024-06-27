part of 'notes_list_cubit.dart';

sealed class NotesListState extends Equatable {
  const NotesListState();

  @override
  List<Object> get props => [];
}

final class NotesListLoading extends NotesListState {
  const NotesListLoading();
  @override
  List<Object> get props => [];
}

final class NotesListUpdate extends NotesListState {
  final List<Note> notes;
  final bool isListView;

  const NotesListUpdate({required this.notes, required this.isListView});

  @override
  List<Object> get props => [notes, isListView];
}
