import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NoteDetailScreen.dart';
import 'ProfileScreen.dart';
import 'auth_provider.dart';
import 'notes_provider.dart';

// import '../providers/auth_provider.dart';
// import '../providers/notes_provider.dart';
// import 'note_detail_screen.dart';
// import 'profile_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      Provider.of<NotesProvider>(context, listen: false).fetchNotes(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {
          final note = notesProvider.notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.timestamp.toDate().toString()),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => NoteDetailScreen(note: note))),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await notesProvider.deleteNote(note.id!);
                await notesProvider.fetchNotes(user!.uid);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const NoteDetailScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
