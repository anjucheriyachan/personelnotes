import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:notes_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

import 'AuthProvider.dart';

class NoteEditScreen extends StatefulWidget {
  final DocumentSnapshot? note;
  const NoteEditScreen({this.note});
  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'];
      _contentController.text = widget.note!['content'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.note != null ? "Edit Note" : "Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title")),
            TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: "Content")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (widget.note != null) {
                  await widget.note!.reference.update({
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'timestamp': Timestamp.now(),
                  });
                } else {
                  await FirebaseFirestore.instance.collection('notes').add({
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'userId': user!.uid,
                    'timestamp': Timestamp.now(),
                  });
                }
                Navigator.pop(context);
              },
              child: Text(widget.note != null ? "Update Note" : "Add Note"),
            )
          ],
        ),
      ),
    );
  }
}
