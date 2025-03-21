import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepository {
  final CollectionReference notesRef =
  FirebaseFirestore.instance.collection('notes');

  Future<void> deleteNote(DocumentReference reference) async {
    await reference.delete();
  }

  Future<void> updateNote(DocumentReference reference, String title, String content) async {
    await reference.update({
      'title': title,
      'content': content,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addNote(String title, String content, String userId) async {
    await notesRef.add({
      'title': title,
      'content': content,
      'userId': userId,
      'timestamp': Timestamp.now(),
    });
  }
}
