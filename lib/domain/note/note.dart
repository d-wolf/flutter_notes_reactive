import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String category;
  final String content;

  const Note({
    this.id,
    required this.title,
    required this.category,
    required this.content,
  });

  @override
  List<Object?> get props => [id, title, category, content];
}
