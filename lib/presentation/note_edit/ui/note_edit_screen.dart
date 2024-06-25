import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/domain/note/note.dart';
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
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _textEditingControllerTitle,
                    ),
                    TextField(
                      controller: _textEditingControllerCategory,
                    ),
                    TextField(
                      controller: _textEditingControllerContent,
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<NoteEditCubit>().onUpdate(
                        Note(
                            title: _textEditingControllerTitle.text,
                            category: _textEditingControllerCategory.text,
                            content: _textEditingControllerContent.text),
                      );
                },
                child: const Icon(Icons.save),
              ),
            );
          default:
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
