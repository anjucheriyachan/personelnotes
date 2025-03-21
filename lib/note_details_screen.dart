import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'note_edit_screen.dart';
// import 'package:notes_app/screens/note_edit_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final DocumentSnapshot note;
  NoteDetailsScreen(this.note);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await note.reference.delete();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => NoteEditScreen(note: note))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(note['content'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Created: ${note['timestamp'].toDate().toString()}",
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
