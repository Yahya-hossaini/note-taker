import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Screens/edit_note_page.dart';
import '../providers/notes.dart';
import '../providers/notes_provider.dart';
import '../styles.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Notes note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        height: 67,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    note.title,
                    style: kNoteCardTextStyle,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm')
                        .format(note.createdAt),
                    style: kNoteCardTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await Provider.of<NotesProvider>(
                          context,
                          listen: false)
                          .deleteNote(note.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        EditNotePage.routeName,
                        arguments: note.id,
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}