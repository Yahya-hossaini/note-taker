import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../styles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/note_card.dart';
import '../widgets/note_counter.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).fetchNotes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<NotesProvider>(context, listen: false).fetchNotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 60),
        child: const CustomAppbar(
          leftSideSelector: 'logout',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(
          child: Column(
            children: [
              NoteCounter(),
              const SizedBox(height: 36),
              CustomTextField(
                hintText: 'Enter the title',
                title: 'Search',
                controller: _searchController,
                obscureText: false,
                onChanged: (value){
                  Provider.of<NotesProvider>(context, listen: false).searchNotes(value);
                },
              ),
              const Divider(height: 30, color: Colors.black87, thickness: 1),
              Expanded(
                child: Consumer<NotesProvider>(
                  builder: (context, notesData, child) {
                    return ListView.builder(
                      itemCount: notesData.notes.length,
                      itemBuilder: (context, index) {
                        final note = notesData.notes[index];
                        return NoteCard(note: note);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNotePage.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF54F34F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}