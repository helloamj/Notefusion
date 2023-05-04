import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notefusion/providers/notes_provider.dart';
import '../models/note.dart';
import 'package:path_provider_android/messages.g.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  bool isUpdate;
  Note? note;

  NotePage({super.key, required this.isUpdate, this.note});
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  FocusNode nodeFocus = FocusNode();
  final titlecontroller = TextEditingController();
  final contentcontroller = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdate == true) {
      titlecontroller.text = widget.note!.title!;
      contentcontroller.text = widget.note!.content!;
    }
  }

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        leading: FittedBox(
          fit: BoxFit.scaleDown,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 27),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff3B3B3B),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ),
        actions: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: GestureDetector(
              onTap: () {
                var title = titlecontroller.text;
                var content = contentcontroller.text;

                if (widget.isUpdate) {
                  widget.note!.title = titlecontroller.text;
                  widget.note!.content = contentcontroller.text;
                  Provider.of<NotesProvider>(context, listen: false)
                      .updateNote(widget.note!);
                } else {
                  Note newNote = Note(
                    id: const Uuid().v1(),
                    userid: NotesProvider.deviceId,
                    content: content,
                    title: title,
                    dateadded: DateTime.now(),
                  );
                  Provider.of<NotesProvider>(context, listen: false)
                      .addNote(newNote);
                }
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 25),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff3B3B3B),
                ),
                child: Icon(Icons.done, color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: const Color(0xff252525),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: titlecontroller,
              autofocus: (widget.isUpdate == true) ? false : true,
              onSubmitted: (value) {
                if (value != '') nodeFocus.requestFocus();
              },
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                textStyle: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              maxLines: 2,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: const Color(0xff3B3B3B),
                filled: true,
                hintText: 'Title...',
                hintStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  textStyle:
                      const TextStyle(color: Colors.white54, fontSize: 25),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextField(
              controller: contentcontroller,
              focusNode: nodeFocus,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w200,
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              maxLines: 100,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: const Color(0xff3B3B3B),
                filled: true,
                hintText: 'Content...',
                hintStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w200,
                  textStyle:
                      const TextStyle(color: Colors.white54, fontSize: 20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
