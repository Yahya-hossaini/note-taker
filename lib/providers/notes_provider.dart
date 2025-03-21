import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:collection/collection.dart';
import 'notes.dart';

class NotesProvider with ChangeNotifier {

  //two lists, one for general notes, one for filtered notes.
  List<Notes> _notes = [];
  List<Notes> _filteredNotes = [];

  //a getter for both lists since they are private
  List<Notes> get notes {
    return _filteredNotes.isNotEmpty ? _filteredNotes : _notes;
  }

  //----------------------------------------------------------------------------
  //The add not function
  Future<void> addNote(String title, String content) async {
    //filtering based on user id
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      print("User is not logged in.");
      return;
    }

    //receiving repose for inserting data in certain table
    final response = await Supabase.instance.client.from('notes').insert({
      'title': title,
      'content': content,
      'user_id': userId, // Attach the user ID to the note
      'created_at': DateTime.now().toIso8601String(),
    });

    //error handling
    if (response.error == null) {
      print('Note added successfully!');
    } else {
      print('Error: ${response.error!.message}');
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  //finding note, based on id
  Notes? findById(String id) {
    return _notes.firstWhereOrNull((note) => note.id == id);
  }

  //----------------------------------------------------------------------------
  //fetching data from Supabase
  Future<void> fetchNotes() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) {
        print("User is not logged in.");
        return;
      }

      print("Fetching notes for user ID: $userId");

      final response = await Supabase.instance.client
          .from('notes')
          .select()
          .eq('user_id', userId); // Filter by user ID

      print("Raw response from Supabase: $response");

      if (response.isEmpty) {
        print("No notes found in Supabase.");
        _notes = [];
      } else {
        _notes = response.map<Notes>((json) => Notes.fromJson(json)).toList();
        _notes.sort((a, b) => a.createdAt.compareTo(b.createdAt)); //sorting based on creation date
        print("Fetched ${_notes.length} notes from Supabase.");
      }
      _filteredNotes = []; // Reset search results
      notifyListeners(); // Notify UI to refresh
    } catch (error) {
      print("Error fetching notes: $error");
    }
  }

  //----------------------------------------------------------------------------
  //searching for a certain note based on name
  void searchNotes(String query) {
    if (query.isEmpty) {
      _filteredNotes = [];
    } else {
      _filteredNotes = _notes
          .where((note) => note.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  //deleting notes based on id
  Future<void> deleteNote(String id) async {
    try {
      print("Attempting to delete note with ID: $id");

      final response =
          await Supabase.instance.client.from('notes').delete().eq('id', id);

      print("Delete response: $response");

      // If deletion is successful, remove from local list
      _notes.removeWhere((note) => note.id == id);
      notifyListeners(); // Update UI
      print("Note deleted successfully!");
    } catch (error) {
      print("Error deleting note: $error");
    }
    notifyListeners();
  }

  //----------------------------------------------------------------------------
  //saving the edited data
  Future<void> saveChanges(String id, String newTitle, String newContent) async {
    try {
      final response = await Supabase.instance.client.from('notes').update({
        'title': newTitle,
        'content': newContent,
      }).eq('id', id);

      if (response.error == null) {
        print('Note updated successfully!');

        // Update the local list
        final index = _notes.indexWhere((note) => note.id == id);
        if (index != -1) {
          _notes[index] = Notes(
            id: id,
            title: newTitle,
            content: newContent,
            createdAt: _notes[index].createdAt, // Keep original date
          );
          _notes.sort((a, b) => a.createdAt.compareTo(b.createdAt));// re-sorting the list. the a and b represent the two notes for comparing
        }

        notifyListeners();
      } else {
        print('Error updating note: ${response.error!.message}');
      }
    } catch (error) {
      print("Error saving changes: $error");
    }
  }
}
