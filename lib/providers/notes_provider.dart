import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notes.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notes = [];

  List<Notes> get notes {
    return [..._notes];
  }

  Future<void> addNote(String title, String content) async {
    final response = await Supabase.instance.client.from('notes').insert({
      'title': title,
      'content': content,
      'created_at': DateTime.now().toIso8601String()
    });

    if (response.error == null) {
      print('Note added successfully!');
    } else {
      print('Error: ${response.error!.message}');
    }
  }

  Future<void> fetchNotes() async {
    try {
      print("Fetching notes from Supabase...");

      final response = await Supabase.instance.client.from('notes').select();

      print("Raw response from Supabase: $response");

      if (response.isEmpty) {
        print("No notes found in Supabase.");
        _notes = [];
      } else {
        _notes = response.map<Notes>((json) => Notes.fromJson(json)).toList();
        print("Fetched ${_notes.length} notes from Supabase.");
      }

      notifyListeners(); // Notify UI to refresh
    } catch (error) {
      print("Error fetching notes: $error");
    }
  }

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

    print("Deleting note with ID: $id");

    _notes.removeWhere((note) => note.id == id); // Remove from local list
    notifyListeners(); // Update UI

    print("Note deleted successfully!");
  }
}
