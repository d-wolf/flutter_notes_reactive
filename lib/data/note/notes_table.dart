import 'package:drift/drift.dart';
import 'package:simple_app/domain/note/note.dart';

@UseRowClass(Note)
class NotesTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {id};
}
