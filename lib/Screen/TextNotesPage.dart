import 'package:flutter/material.dart';

import '../DataBase/NotesDataBase.dart';
import '../Model/Motes.dart';
import '../Utils/Widget/Notes/NotesCardWidget.dart';
import 'edit_notes.dart';
import 'notes_detail_page.dart';


class TextNotesPage extends StatefulWidget {
  @override
  _TextNotesPageState createState() => _TextNotesPageState();
}

class _TextNotesPageState extends State<TextNotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    //  NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Notes',
        style: TextStyle(fontSize: 24),
      ),
      actions: [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : notes.isEmpty
          ? Text(
        'No Notes',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton:ElevatedButton.icon(onPressed: () async {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddEditNotePage()),
      );

      refreshNotes();
    }, icon: Icon(Icons.add_box), label: Text("Add A Note"),
    ) ,
  );

  Widget buildNotes() => GridView.builder(
    padding: EdgeInsets.all(8),
    itemCount: notes.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 4.2/5
    ),
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!,index: index, ),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );
}
