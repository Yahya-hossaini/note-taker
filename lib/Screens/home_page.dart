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
  //----------------------------------------------------------------------------
  //fetching data from server before everything
  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).fetchNotes();
  }
  //----------------------------------------------------------------------------
  //fetching data if some dependencies or data have been changed
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<NotesProvider>(context, listen: false).fetchNotes();
  }
  //----------------------------------------------------------------------------
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
              //counter for counting the number of notes
              NoteCounter(),
              const SizedBox(height: 36),
              //A search bar for searching specific note by name
              CustomTextField(
                hintText: 'Enter the title',
                title: 'Search',
                controller: _searchController,
                obscureText: false,
                onChanged: (value){
                  Provider.of<NotesProvider>(context, listen: false).searchNotes(value);
                },
                keyboardType: TextInputType.name,
              ),
              const Divider(height: 30, color: Colors.black87, thickness: 1),
              //List of notes
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
      //button for navigating to add note page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNotePage.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: kButtonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}