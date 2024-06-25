part of 'note_edit_cubit.dart';

sealed class NoteEditState extends Equatable {
  const NoteEditState();

  @override
  List<Object> get props => [];
}

final class NoteEditUpdate extends NoteEditState {
  final Note note;

  const NoteEditUpdate({required this.note});

  @override
  List<Object> get props => [note];
}
