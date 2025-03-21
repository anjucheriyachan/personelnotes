import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/repositories/notes_repository.dart';

import 'note_edit_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final DocumentSnapshot note;
  const NoteDetailsScreen(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    final noteRepo = NoteRepository();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Note Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber.shade700,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () async {
              await noteRepo.deleteNote(note.reference);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => NoteEditScreen(note: note),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note['title'], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber.shade700)),
              const SizedBox(height: 20),
              Text(note['content'], style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.5)),
              const SizedBox(height: 30),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 10),
              const Text("Created on:", style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(note['timestamp'].toDate().toString(), style: const TextStyle(color: Colors.white54, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
