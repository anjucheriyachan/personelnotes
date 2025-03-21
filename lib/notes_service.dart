// notes_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNote(String title, String content) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('notes').add({
        'userId': user.uid,
        'title': title,
        'content': content,
        'timestamp': Timestamp.now(),
      });
    }
  }

  Stream<QuerySnapshot> getNotesStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _firestore
          .collection('notes')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .snapshots();
    } else {
      return const Stream.empty();
    }
  }

  Future<void> updateNote(String noteId, String title, String content) async {
    await _firestore.collection('notes').doc(noteId).update({
      'title': title,
      'content': content,
    });
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
