import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note/profile_screen.dart';
import 'package:provider/provider.dart';
import 'AuthProvider.dart';
import 'note_details_screen.dart';
import 'note_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.amber.shade700,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfileScreen())),
            icon: Icon(Icons.person, color: Colors.black),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .where('userId', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber.shade700,
                ));
          }
          final notes = snapshot.data!.docs;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                color: Colors.grey.shade900,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ListTile(
                  title: Text(
                    note['title'],
                    style: TextStyle(
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text(
                    note['timestamp'].toDate().toString(),
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.white54),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NoteDetailsScreen(note))),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.black,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => NoteEditScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
