import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/data/database/app_database.dart';
import 'package:simple_app/data/note/notes_repository_impl.dart';
import 'package:simple_app/domain/note/note.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  final notesRepository = NotesRepositoryImpl(dao: db.notesDao);

  final notes = await notesRepository.getNotes();

  if (notes.isEmpty) {
    for (var i = 0; i < 10; i++) {
      notesRepository.insertNote(Note(
          title: 'title:$i', category: 'category:$i', content: 'content:$i'));
    }
  }

  runApp(MyApp(
    notesRepository: notesRepository,
  ));
}

class MyApp extends StatelessWidget {
  final NotesRepository _notesRepository;

  const MyApp({required NotesRepository notesRepository, super.key})
      : _notesRepository = notesRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => NotesListCubit(
          notesRepository: _notesRepository,
        ),
        child: const NotesListScreen(),
      ),
    );
  }
}
