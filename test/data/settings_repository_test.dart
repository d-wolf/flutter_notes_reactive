// import 'package:drift/native.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:rx_shared_preferences/rx_shared_preferences.dart';
// import 'package:simple_app/data/settings/notes_repository_impl.dart';
// import 'package:simple_app/data/settings/settings_data_source.dart';
// import 'package:simple_app/domain/note/note.dart';
// import 'package:simple_app/domain/settings/settings_repository.dart';

// class MockRxSharedPreferences extends Mock implements RxSharedPreferences {}

// void main() {
//   late SettingsRepository repository;

//   setUp(() {
//     repository = SettingsRepositoryImpl(
//         source: SettingsDataSource(prefs: MockRxSharedPreferences()));
//   });

//   test('insert note with id null into empty db returns id 1', () async {
//     const note = Note(title: 'title', category: 'category', content: 'content');

//     final id = await repository.insertNote(note);

//     expect(id, 1);
//   });

//   test('insert with specific id is inserted with id', () async {
//     const note =
//         Note(id: 12, title: 'title', category: 'category', content: 'content');

//     final id = await repository.insertNote(note);

//     expect(id, 12);
//   });

//   test('insert notes with same ids throws', () async {
//     const note =
//         Note(id: 12, title: 'title', category: 'category', content: 'content');

//     await repository.insertNote(note);

//     expect(() => repository.insertNote(note), throwsA(isA<SqliteException>()));
//   });

//   test('getNote from db equals inserted note', () async {
//     const note =
//         Note(id: 1, title: 'title', category: 'category', content: 'content');

//     await repository.insertNote(note);

//     expect(await repository.getNote(1), note);
//   });

//   test('getNotes returns all notes from db', () async {
//     final list = List.generate(
//       3,
//       (index) => Note(
//           id: index + 1,
//           title: 'title',
//           category: 'category',
//           content: 'content'),
//     );

//     for (var element in list) {
//       await repository.insertNote(element);
//     }

//     expect(await repository.getNotes(), list);
//   });

//   test('getNotesStream emits newly inserted notes', () async {
//     const note =
//         Note(id: 1, title: 'title', category: 'category', content: 'content');

//     final expectation = expectLater(
//       repository.getNotesStream(),
//       emitsInOrder([
//         [],
//         [note],
//       ]),
//     );

//     await repository.insertNote(note);

//     await expectation;
//   });

//   test('getNotesStream emits updated notes', () async {
//     const note =
//         Note(id: 1, title: 'title', category: 'category', content: 'content');
//     const noteEmpty = Note(id: 1, title: '', category: '', content: '');

//     final expectation = expectLater(
//       repository.getNotesStream(),
//       emitsInOrder([
//         [],
//         [noteEmpty],
//       ]),
//     );

//     await repository.insertNote(note);
//     await repository
//         .updateNote(const Note(id: 1, title: '', category: '', content: ''));

//     await expectation;
//   });

//   test('getNoteStream emits updated note', () async {
//     const note =
//         Note(id: 1, title: 'title', category: 'category', content: 'content');
//     const noteEmpty = Note(id: 1, title: '', category: '', content: '');

//     await repository.insertNote(note);

//     final expectation = expectLater(
//       repository.getNoteStream(1),
//       emitsInOrder([
//         note,
//         noteEmpty,
//       ]),
//     );

//     await repository.updateNote(noteEmpty);

//     await expectation;
//   });
// }
