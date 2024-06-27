import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/app_router.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

class NotesListScreen extends StatelessWidget {
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
                  ? _buildList(context, update)
                  : _buildGrid(context, update),
              floatingActionButton: FloatingActionButton(
                  key: const Key('add'),
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

  Widget _buildList(BuildContext context, NotesListUpdate update) {
    return ListView.separated(
      itemCount: update.notes.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        indent: 8,
        endIndent: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ValueKey(update.notes[index].id),
          background: Container(
            color: Theme.of(context).colorScheme.error,
          ),
          onDismissed: (direction) {
            context.read<NotesListCubit>().onDelete(update.notes[index]);
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            title: Text(update.notes[index].title),
            subtitle: Text(update.notes[index].category),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push(RouterPaths.noteDetail,
                  extra: update.notes[index].id);
            },
          ),
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context, NotesListUpdate update) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(update.notes.length, (index) {
        final note = update.notes[index];
        return Card(
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
                          context.read<NotesListCubit>().onDelete(note);
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
        );
      }),
    );
  }
}
