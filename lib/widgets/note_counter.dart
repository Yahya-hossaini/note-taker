import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../styles.dart';

class NoteCounter extends StatelessWidget {
  const NoteCounter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kCardColor,
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              'Total Notes Number:',
              style: kNoteCounterTitleTextStyle,
            ),
          ),
          Consumer<NotesProvider>(
            builder: (context, notesData, child) {
              return Text(
                '${notesData.notes.length}',
                style: kNoteCounterTextStyle,
              );
            },
          ),
        ],
      ),
    );
  }
}