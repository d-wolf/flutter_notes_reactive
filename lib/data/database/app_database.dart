import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart' as native;
import 'package:path_provider/path_provider.dart';
import 'package:simple_app/data/note/notes_dao.dart';
import 'package:simple_app/data/note/notes_table.dart';
import 'package:simple_app/domain/note/note.dart';

part 'app_database.g.dart';

const _kDBname = 'db.sqlite';

@DriftDatabase(
  tables: [
    NotesTable,
  ],
  daos: [
    NotesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? connection})
      : super(connection ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (Migrator m, int from, int to) async {},
      );

  Future<void> deleteAllTables() {
    return transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, _kDBname));
      return native.NativeDatabase.createInBackground(file);
    });
  }
}
