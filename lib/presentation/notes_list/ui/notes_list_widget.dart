import 'package:flutter/material.dart';
import 'package:simple_app/domain/note/note.dart';

class NotesListWidget extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note note)? onNote;
  final void Function(Note note)? onDelete;

  const NotesListWidget(
      {required this.notes, this.onNote, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        indent: 8,
        endIndent: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(notes[index].id),
          background: Container(
            color: Theme.of(context).colorScheme.error,
          ),
          onDismissed: (direction) {
            onDelete?.call(notes[index]);
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            title: Text(notes[index].title),
            subtitle: Text(notes[index].category),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              onNote?.call(notes[index]);
            },
          ),
        );
      },
    );
  }
}
