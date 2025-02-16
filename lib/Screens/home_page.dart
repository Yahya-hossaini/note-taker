import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_project/notes_provider.dart';
import 'package:supabase_project/widgets/custom_text_field.dart';

import '../widgets/custom_appbar.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final notesData = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E2939),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Center(
          child: Column(
            children: [
              // Notes reader. it read the total amount of notes in app
              Container(
                height: 135,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF404040),
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
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Text(
                      '${notesData.notes.length}',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFF54F34F),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              CustomTextField(
                hintText: 'Enter the title',
                title: 'Search',
                controller: searchController,
              ),
              // SizedBox(height: 12,),
              Divider(
                height: 30,
                color: Colors.black87,
                thickness: 1,
              ),
              // ListView.builder(itemBuilder: (ctx, index) => NotesProvider());
              Expanded(
                child: ListView.builder(
                  itemCount: notesData.notes.length,
                  itemBuilder: (context, index) {
                    final note = notesData.notes[index];
                    // return ListTile(
                    //   title: Text(note.title),
                    //   subtitle: Text(DateFormat('yyyy-MM-dd HH:mm')
                    //       .format(note.createdAt)),
                    //   trailing: IconButton(
                    //     icon: Icon(Icons.delete),
                    //     onPressed: () {
                    //       notesData.deleteNote(note.id);
                    //     },
                    //   ),
                    // );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        height: 67,
                        decoration: BoxDecoration(
                          color: Color(0xFF404040),
                          borderRadius: BorderRadius.circular(12)
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
                                  Text(note.title, style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                                  Text(DateFormat('yyyy-MM-dd HH:mm').format(note.createdAt), style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.redAccent,),),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.open_in_new, color: Colors.white,),),
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
