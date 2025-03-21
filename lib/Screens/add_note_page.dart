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

  //----------------------------------------------------------------------------
  //Saving the entered data
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
  //----------------------------------------------------------------------------
  //showing dialog before user go back to homepage, assuring user saving the edited data
  void _showSaveChangesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Save your note?'),
          content: Text('Do you want to save your note before leaving?'),
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
                _saveNote();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  //----------------------------------------------------------------------------
  //to make sure user save note before leaving. handling the back buttons
  _handleTextFields(){
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if(title.isNotEmpty || content.isNotEmpty){
      _showSaveChangesDialog();
    }else{
      Navigator.pop(context);
    }
  }
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).orientation == Orientation.portrait ? 80 : 60,
          ),
          child: CustomAppbar(
            leftSideSelector: 'back',
            onBackPressed: _handleTextFields,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          child: Column(
            children: [
              //the first input for title
              NoteTitle(titleController: _titleController),
              const SizedBox(
                height: 10,
              ),
              // the second input for writing the notes
              TextArea(contentController: _contentController),
            ],
          ),
        ),
        //An add button for adding the notes to database
        floatingActionButton: GestureDetector(
          onTap: _saveNote,
          child: AddSaveButton(title: 'Add'),
        ),
      ),
    );
  }
}
