import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_project/Screens/home_page.dart';
import 'package:supabase_project/providers/notes_provider.dart';
import 'package:supabase_project/styles.dart';
import 'package:supabase_project/widgets/custom_appbar.dart';

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
            rightSideSelector: 'save', leftSideSelector: 'back'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Write your note here',
                  hintStyle: TextStyle(color: kPrimaryColor),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Add', style: TextStyle(fontSize: 16),),
                Icon(Icons.add),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: kButtonColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
