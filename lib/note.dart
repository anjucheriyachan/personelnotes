import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? id;
  final String uid;
  final String title;
  final String content;
  final Timestamp timestamp;

  Note({
    this.id,
    required this.uid,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory Note.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      uid: data['uid'],
      title: data['title'],
      content: data['content'],
      timestamp: data['timestamp'],
    );
  }
}
