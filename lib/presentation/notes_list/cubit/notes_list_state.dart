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

  const NotesListUpdate({required this.notes});

  @override
  List<Object> get props => [notes];
}
