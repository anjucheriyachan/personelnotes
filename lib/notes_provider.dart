import 'package:flutter/material.dart';

//
// import '../models/note.dart';
// import '../services/firestore_service.dart';
import 'firestore_service.dart';
import 'note.dart';

class NotesProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes(String uid) async {
    _notes = await _firestoreService.getUserNotes(uid);
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _firestoreService.addNote(note);
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    await _firestoreService.deleteNote(noteId);
    notifyListeners();
  }
}
