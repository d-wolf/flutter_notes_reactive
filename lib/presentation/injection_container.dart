import 'package:get_it/get_it.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:simple_app/data/database/app_database.dart';
import 'package:simple_app/data/note/notes_repository_impl.dart';
import 'package:simple_app/data/settings/notes_repository_impl.dart';
import 'package:simple_app/data/settings/settings_data_source.dart';
import 'package:simple_app/domain/note/notes_repository.dart';
import 'package:simple_app/domain/settings/settings_repository.dart';
import 'package:simple_app/presentation/note_add/cubit/note_add_cubit.dart';
import 'package:simple_app/presentation/note_detail/cubit/note_detail_cubit.dart';
import 'package:simple_app/presentation/note_edit/cubit/note_edit_cubit.dart';
import 'package:simple_app/presentation/notes_list/cubit/notes_list_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerFactory<NotesListCubit>(
      () => NotesListCubit(notesRepository: sl(), settingsRepository: sl()));
  sl.registerFactoryParam<NoteDetailCubit, int, void>(
      (id, _) => NoteDetailCubit(noteId: id, notesRepository: sl()));
  sl.registerFactoryParam<NoteEditCubit, int, void>(
      (id, _) => NoteEditCubit(noteId: id, notesRepository: sl()));
  sl.registerFactory<NoteAddCubit>(() => NoteAddCubit(notesRepository: sl()));
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(source: sl()));

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SettingsDataSource>(
      () => SettingsDataSource(prefs: RxSharedPreferences(prefs)));

  final db = AppDatabase();
  sl.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(dao: db.notesDao));
}
