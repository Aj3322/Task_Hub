import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../DataBase/NotesDataBase.dart';
import '../Model/Motes.dart';
import 'edit_notes.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  final int index;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
    required this.index,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }
  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[widget.index % _lightColors.length];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        color: color,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                note.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                DateFormat.yMMMd().format(note.createdTime),
                style: TextStyle(color: Colors.black38),
              ),
              SizedBox(height: 8),
              Text(
                note.description,
                style: TextStyle(color: Colors.black87, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note,index: widget.index),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
    icon: Icon(Icons.delete),
    onPressed: () async {
      await NotesDatabase.instance.delete(widget.noteId);

      Navigator.of(context).pop();
    },
  );
}
