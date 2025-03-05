import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_notes/providers/notes_provider.dart';
import 'package:my_notes/widgets/custom_appbar.dart';
import '../styles.dart';
import '../widgets/add_save_button.dart';
import '../widgets/note_title.dart';
import '../widgets/text_area.dart';

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
            NoteTitle(titleController: _titleController),
            const SizedBox(
              height: 10,
            ),
            TextArea(contentController: _contentController),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: _saveChanges,
        child: AddSaveButton(title: 'Save',),
      ),
    );
  }
}