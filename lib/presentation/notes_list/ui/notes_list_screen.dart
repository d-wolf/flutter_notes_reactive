import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

class NotesListScreen extends StatelessWidget {
  final void Function(Note note)? onDetail;

  const NotesListScreen({this.onDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
        ),
        body: BlocBuilder<NotesListCubit, NotesListState>(
          builder: (context, state) {
            switch (state) {
              case NotesListUpdate update:
                return ListView.builder(
                  itemCount: update.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey(update.notes[index].id),
                      background: Container(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onDismissed: (direction) {
                        context
                            .read<NotesListCubit>()
                            .onDelete(update.notes[index]);
                      },
                      child: ListTile(
                        title: Text(update.notes[index].title),
                        subtitle: Text(update.notes[index].category),
                        onTap: () {
                          onDetail?.call(update.notes[index]);
                        },
                      ),
                    );
                  },
                );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
