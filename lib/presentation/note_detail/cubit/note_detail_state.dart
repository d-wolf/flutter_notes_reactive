part of 'note_detail_cubit.dart';

sealed class NoteDetailState extends Equatable {
  const NoteDetailState();

  @override
  List<Object> get props => [];
}

final class NoteDetailLoading extends NoteDetailState {
  const NoteDetailLoading();

  @override
  List<Object> get props => [];
}

final class NoteDetailUpdate extends NoteDetailState {
  final Note note;

  const NoteDetailUpdate({required this.note});

  @override
  List<Object> get props => [note];
}
