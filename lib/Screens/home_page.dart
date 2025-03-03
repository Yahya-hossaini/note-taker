import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../styles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_text_field.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';

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
          leftSideSelector: 'menu',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(
          child: Column(
            children: [
              Container(
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
              ),
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
