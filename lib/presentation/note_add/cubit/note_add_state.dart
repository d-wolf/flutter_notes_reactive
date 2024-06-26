part of 'note_add_cubit.dart';

sealed class NoteAddState extends Equatable {
  const NoteAddState();

  @override
  List<Object> get props => [];
}

final class NoteAddLoading extends NoteAddState {
  const NoteAddLoading();

  @override
  List<Object> get props => [];
}

final class NoteAddUpdate extends NoteAddState {
  const NoteAddUpdate();

  @override
  List<Object> get props => [];
}

final class NoteAddSuccess extends NoteAddState {
  const NoteAddSuccess();

  @override
  List<Object> get props => [];
}
