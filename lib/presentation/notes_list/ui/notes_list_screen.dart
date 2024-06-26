import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/app_router.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        ),
        body: BlocBuilder<NotesListCubit, NotesListState>(
          builder: (context, state) {
            switch (state) {
              case NotesListUpdate update:
                return ListView.separated(
                  itemCount: update.notes.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
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
                        context
                            .read<NotesListCubit>()
                            .onDelete(update.notes[index]);
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

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
