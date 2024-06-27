import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/app_router.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';

class NoteDetailScreen extends StatelessWidget {
  static const textFieldTitleKey = 'TEXT_FIELD_TITLE';
  static const textFieldCategoryKey = 'TEXT_FIELD_CATEGORY';
  static const textFieldContentKey = 'TEXT_FIELD_CONTENT';

  const NoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteDetailCubit, NoteDetailState>(
      builder: (context, state) {
        switch (state) {
          case NoteDetailUpdate update:
            return Scaffold(
              appBar: AppBar(
                title:
                    Text(key: const Key(textFieldTitleKey), update.note.title),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Category'),
                          subtitle: Text(
                              key: const Key(textFieldCategoryKey),
                              update.note.category),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                            key: const Key(textFieldContentKey),
                            update.note.content),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () {
                  context.push(RouterPaths.noteEdit, extra: update.note.id);
                },
              ),
            );

          default:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
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
