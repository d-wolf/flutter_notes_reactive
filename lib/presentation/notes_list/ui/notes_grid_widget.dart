import 'package:flutter/material.dart';
import 'package:simple_app/domain/note/note.dart';

class NotesGridWidget extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note note)? onNote;
  final void Function(Note note)? onDelete;

  const NotesGridWidget(
      {required this.notes, this.onNote, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(notes.length, (index) {
        final note = notes[index];
        return Card(
          child: InkWell(
            onTap: () {
              onNote?.call(note);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              note.category,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                          onPressed: () {
                            onDelete?.call(note);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      note.content,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
