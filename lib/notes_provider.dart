
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notes.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notes = [
    Notes(
      id: '1',
      title: 'Math',
      content:
          'Why end might ask civil again spoil. She dinner she our horses depend. Remember at children by reserved to vicinity. In affronting unreserved delightful simplicity ye. Law own advantage furniture continual sweetness bed agreeable perpetual. Oh song well four only head busy it. Afford son she had lively living. Tastes lovers myself too formal season our valley boy. Lived it their their walls might to by young.',
      createdAt: DateTime.now(),
    ),
    Notes(
      id: '2',
      title: 'English',
      content:
          'Fat new smallness few supposing suspicion two. Course sir people worthy horses add entire suffer. How one dull get busy dare far. At principle perfectly by sweetness do. As mr started arrival subject by believe. Strictly numerous outlived kindness whatever on we no on addition.',
      createdAt: DateTime.now(),
    ),
    Notes(
      id: '3',
      title: 'Geometery',
      content:
          'Surprise steepest recurred landlord mr wandered amounted of. Continuing devonshire but considered its. Rose past oh shew roof is song neat. Do depend better praise do friend garden an wonder to. Intention age nay otherwise but breakfast. Around garden beyond to extent by.',
      createdAt: DateTime.now(),
    ),
    Notes(
      id: '4',
      title: 'Literature',
      content:
          'Sociable on as carriage my position weddings raillery consider. Peculiar trifling absolute and wandered vicinity property yet. The and collecting motionless difficulty son. His hearing staying ten colonel met. Sex drew six easy four dear cold deny. Moderate children at of outweigh it. Unsatiable it considered invitation he travelling insensible.',
      createdAt: DateTime.now(),
    ),
  ];
  List<Notes> get notes {
    return [..._notes];
  }

  Future<void> addNote(String title, String content) async {
    final response = await Supabase.instance.client.from('notes').insert({
      'title': title,
      'content': content,
      'create_at': DateTime.now().toIso8601String()
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

      final response = await Supabase.instance.client
          .from('notes')
          .select();

      if (response.isEmpty) {
        print("No notes found in Supabase.");
        _notes = [];
      } else {
        _notes = response.map<Notes>((json) => Notes.fromJson(json)).toList();
        print("Fetched ${_notes.length} notes from Supabase.");
      }

      notifyListeners();
    } catch (error) {
      print("Error fetching notes: $error");
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      print("Attempting to delete note with ID: $id");

      final response = await Supabase.instance.client
          .from('notes')
          .delete()
          .eq('id', id);

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
