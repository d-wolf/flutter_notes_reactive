import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/app_router.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_grid_widget.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_widget.dart';

class NotesListScreen extends StatelessWidget {
  static const addKey = 'add';

  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesListCubit, NotesListState>(
      builder: (context, state) {
        switch (state) {
          case NotesListUpdate update:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Notes'),
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<NotesListCubit>().onSwitchLayout();
                      },
                      icon: Icon(
                          update.isListView ? Icons.grid_view : Icons.list))
                ],
              ),
              body: update.isListView
                  ? NotesListWidget(
                      notes: update.notes,
                      onNote: (note) {
                        context.push(RouterPaths.noteDetail, extra: note.id);
                      },
                      onDelete: (note) {
                        context.read<NotesListCubit>().onDelete(note);
                      },
                    )
                  : NotesGridWidget(
                      notes: update.notes,
                      onNote: (note) {
                        context.push(RouterPaths.noteDetail, extra: note.id);
                      },
                      onDelete: (note) {
                        context.read<NotesListCubit>().onDelete(note);
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                  key: const Key(addKey),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    context.push(RouterPaths.noteAdd);
                  }),
            );

          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Notes'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
