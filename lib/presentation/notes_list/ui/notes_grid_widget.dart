import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_app/domain/note/note.dart';

class NotesGridWidget extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note note)? onNote;
  final void Function(Note note)? onDelete;

  const NotesGridWidget(
      {required this.notes, this.onNote, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              onNote?.call(note);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              note.category,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                          onPressed: () {
                            onDelete?.call(note);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Flexible(
                    child: Text(
                      note.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // return StaggeredGrid.count(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 8,
    //     crossAxisSpacing: 8,
    //     children: List.generate(notes.length, (index) {
    //       final note = notes[index];
    //       return Card(
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(12),
    //           ),
    //         ),
    //         clipBehavior: Clip.antiAlias,
    //         child: InkWell(
    //           onTap: () {
    //             onNote?.call(note);
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             note.title,
    //                             style: Theme.of(context).textTheme.titleLarge,
    //                           ),
    //                           Text(
    //                             note.category,
    //                             style: Theme.of(context).textTheme.titleMedium,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     IconButton.filledTonal(
    //                         onPressed: () {
    //                           onDelete?.call(note);
    //                         },
    //                         icon: const Icon(Icons.delete))
    //                   ],
    //                 ),
    //                 const SizedBox(
    //                   height: 8,
    //                 ),
    //                 const Divider(
    //                   indent: 0,
    //                   endIndent: 0,
    //                 ),
    //                 const SizedBox(
    //                   height: 8,
    //                 ),
    //                 Flexible(
    //                   child: Text(
    //                     note.content,
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 3,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }));
  }
}
