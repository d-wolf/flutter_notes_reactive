import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_app/presentation/injection_container.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';
import 'package:simple_app/presentation/note_detail/ui/note_detail_screen.dart';
import 'package:simple_app/presentation/note_edit/cubit/note_edit_cubit.dart';
import 'package:simple_app/presentation/note_edit/ui/note_edit_screen.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';
import 'package:simple_app/presentation/notes_list/ui/notes_list_screen.dart';

class RouterPaths {
  const RouterPaths._();

  static const String notesList = '/notes_list';
  static const String noteDetail = '/note_detail';
  static const String noteEdit = '/note_edit';
}

class AppRouter {
  const AppRouter._();

  static RouterConfig<Object>? getConfig(String initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: RouterPaths.notesList,
          builder: (context, state) => BlocProvider<NotesListCubit>(
            create: (_) => NotesListCubit(notesRepository: sl()),
            child: const NotesListScreen(),
          ),
        ),
        GoRoute(
          path: RouterPaths.noteDetail,
          builder: (context, state) => BlocProvider<NoteDetailCubit>(
            create: (_) => sl(param1: state.extra! as int),
            child: const NoteDetailScreen(),
          ),
        ),
        GoRoute(
          path: RouterPaths.noteEdit,
          builder: (context, state) => BlocProvider<NoteEditCubit>(
            create: (_) => sl(param1: state.extra! as int),
            child: const NoteEditScreen(),
          ),
        ),
      ],
    );
  }
}
