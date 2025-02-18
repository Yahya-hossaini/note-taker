import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_notes/Screens/home_page.dart';
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
    Navigator.pushReplacementNamed(context, HomePage.routeName);
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
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.white38,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Write your note here....',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: _saveNote,
        child: Container(
          height: 36,
          width: 124,
          decoration: BoxDecoration(
            color: kButtonColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Add',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
