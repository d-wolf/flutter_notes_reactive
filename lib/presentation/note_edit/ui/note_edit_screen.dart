import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/presentation/note_edit/cubit/note_edit_cubit.dart';

class NoteEditScreen extends StatefulWidget {
  const NoteEditScreen({super.key});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _textEditingControllerTitle = TextEditingController();
  final _textEditingControllerCategory = TextEditingController();
  final _textEditingControllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteEditCubit, NoteEditState>(
      listener: (BuildContext context, NoteEditState state) {
        switch (state) {
          case NoteEditUpdate update:
            _textEditingControllerTitle.text = update.note.title;
            _textEditingControllerCategory.text = update.note.category;
            _textEditingControllerContent.text = update.note.content;
            break;
          default:
        }
      },
      builder: (context, state) {
        switch (state) {
          case NoteEditUpdate update:
            return Scaffold(
              appBar: AppBar(
                title: Text(update.note.title),
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
              ),
              body: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _textEditingControllerTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _textEditingControllerCategory,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textEditingControllerContent,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<NoteEditCubit>().onUpdate(
                        _textEditingControllerTitle.text,
                        _textEditingControllerCategory.text,
                        _textEditingControllerContent.text,
                      );
                },
                child: const Icon(Icons.save),
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
