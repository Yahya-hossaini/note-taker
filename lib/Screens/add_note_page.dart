import 'package:flutter/material.dart';
import 'package:my_notes/widgets/add_save_button.dart';
import 'package:my_notes/widgets/note_title.dart';
import 'package:my_notes/widgets/text_area.dart';
import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:my_notes/styles.dart';
import 'package:my_notes/widgets/custom_appbar.dart';

class AddNotePage extends StatefulWidget {
  static const routeName = '/add-note-page';
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and content cannot be empty'),
        ),
      );
      return;
    }

    Provider.of<NotesProvider>(context, listen: false).addNote(title, content);
    Provider.of<NotesProvider>(context, listen: false).fetchNotes();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).orientation == Orientation.portrait ? 80 : 60,
        ),
        child: const CustomAppbar(
          leftSideSelector: 'back',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        child: Column(
          children: [
            NoteTitle(titleController: _titleController),
            const SizedBox(
              height: 10,
            ),
            TextArea(contentController: _contentController),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: _saveNote,
        child: AddSaveButton(title: 'Add'),
      ),
    );
  }
}
