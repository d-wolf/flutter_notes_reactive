import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';

class NoteDetailScreen extends StatelessWidget {
  final void Function(Note note)? onEdit;

  const NoteDetailScreen({this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteDetailCubit, NoteDetailState>(
      builder: (context, state) {
        switch (state) {
          case NoteDetailUpdate update:
            return Scaffold(
              appBar: AppBar(
                title: Text(update.note.title),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(update.note.category),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(update.note.content),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () {
                  onEdit?.call(update.note);
                },
              ),
            );

          default:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
