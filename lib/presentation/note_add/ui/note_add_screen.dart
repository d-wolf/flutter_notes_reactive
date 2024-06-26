import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/note_add/cubit/note_add_cubit.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final _textEditingControllerTitle = TextEditingController();
  final _textEditingControllerCategory = TextEditingController();
  final _textEditingControllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteAddCubit, NoteAddState>(
      listener: (context, state) {
        switch (state) {
          case NoteAddSuccess _:
            context.pop();
            break;
          default:
        }
      },
      builder: (context, state) {
        switch (state) {
          case NoteAddUpdate _:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Add note'),
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
              ),
              body: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('form_field_title'),
                        controller: _textEditingControllerTitle,
                        decoration: const InputDecoration(
                            hintText: 'e.g. Shopping List',
                            label: Text('Title')),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        key: const Key('form_field_category'),
                        controller: _textEditingControllerCategory,
                        decoration: const InputDecoration(
                            hintText: 'e.g. buy', label: Text('Category')),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          key: const Key('form_field_content'),
                          controller: _textEditingControllerContent,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          decoration:
                              const InputDecoration(label: Text('Text')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                key: const Key('save'),
                onPressed: () async {
                  context.read<NoteAddCubit>().onAdd(
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
