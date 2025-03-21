import 'package:cloud_firestore/cloud_firestore.dart';

import 'note.dart';



class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Note>> getUserNotes(String uid) async {
    final snapshot =
        await _db.collection('notes').where('uid', isEqualTo: uid).get();
    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<void> addNote(Note note) async {
    await _db.collection('notes').add(note.toMap());
  }

  Future<void> deleteNote(String noteId) async {
    await _db.collection('notes').doc(noteId).delete();
  }
}
