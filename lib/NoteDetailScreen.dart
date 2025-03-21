import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import 'note.dart';
import 'notes_provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Note Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (user == null) return;

                final navigator =
                    Navigator.of(context); // Store navigator reference
                final newNote = Note(
                  uid: user.uid,
                  title: titleController.text.trim(),
                  content: contentController.text.trim(),
                  timestamp: Timestamp.fromDate(DateTime.now()), // ✅ fixed here
                );

                await notesProvider.addNote(newNote);
                await notesProvider.fetchNotes(user.uid);
                navigator.pop(); // Use stored navigator
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
