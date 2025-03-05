import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:my_notes/widgets/custom_appbar.dart';

import '../styles.dart';

class EditNotePage extends StatefulWidget {
  static const routeName = '/edit-note-page';
  final String noteId;

  const EditNotePage({super.key, required this.noteId});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late String _initialTitle;
  late String _initialContent;

  @override
  void initState() {
    super.initState();
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    final note = notesProvider.findById(widget.noteId);
    if (note != null) {
      _titleController.text = note.title;
      _contentController.text = note.content;
      _initialTitle = note.title;
      _initialContent = note.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and content cannot be empty!')),
      );
      return;
    }

    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await notesProvider.saveChanges(
      widget.noteId,
      _titleController.text,
      _contentController.text,
    );
    Navigator.of(context).pop();
  }

  void _showSaveChangesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save changes?'),
          content: Text('Do you want to save changes before leaving?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveChanges();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _handleBackButton(){
    if(_titleController.text != _initialTitle || _contentController.text != _initialContent){
      _showSaveChangesDialog();
    }else{
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).orientation == Orientation.portrait ? 80 : 60,
        ),
        child: CustomAppbar(
          leftSideSelector: 'back',
          onBackPressed: _handleBackButton,
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
        onTap: _saveChanges,
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
                  'Save',
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
