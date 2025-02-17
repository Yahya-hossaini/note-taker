import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_project/Screens/add_note_page.dart';
import 'package:supabase_project/providers/notes_provider.dart';
import 'package:supabase_project/styles.dart';
import 'package:supabase_project/widgets/custom_text_field.dart';

import '../widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final notesData = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 60),
        child: const CustomAppbar(
          leftSideSelector: 'menu',
          rightSideSelector: 'image',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(
          child: Column(
            children: [
              // Notes reader. it read the total amount of notes in app
              Container(
                height: 135,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kCardColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'Total Notes Number:',
                        style: kNoteCounterTitleTextStyle,
                      ),
                    ),
                    Text(
                      '${notesData.notes.length}',
                      style: kNoteCounterTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              CustomTextField(
                hintText: 'Enter the title',
                title: 'Search',
                controller: searchController,
              ),
              // SizedBox(height: 12,),
              const Divider(
                height: 30,
                color: Colors.black87,
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {
                                      notesData.deleteNote(note.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.open_in_new,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
