import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AuthProvider.dart';

class NoteEditScreen extends StatefulWidget {
  final DocumentSnapshot? note;
  const NoteEditScreen({super.key, this.note});
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add Note",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade700,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20,),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.amber.shade700),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _contentController,
                maxLines: 8,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Content",
                  labelStyle: TextStyle(color: Colors.amber.shade700),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    if (widget.note != null) {
                      await widget.note!.reference.update({
                        'title': _titleController.text.trim(),
                        'content': _contentController.text.trim(),
                        'timestamp': Timestamp.now(),
                      });
                    } else {
                      await FirebaseFirestore.instance.collection('notes').add({
                        'title': _titleController.text.trim(),
                        'content': _contentController.text.trim(),
                        'userId': user!.uid,
                        'timestamp': Timestamp.now(),
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.note != null ? "Update Note" : "Add Note",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
