import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/note.dart';
import 'authentication/sign_in_page.dart';
import 'note_page.dart';
import '../providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    // print(FirebaseAuth.instance.currentUser!.email);
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    List<Color> clr = [
      Color(0xffFFAB91),
      Color(0xffFFCC80),
      Color(0xffE6ED9B),
      Color(0xffCF93D9),
      Color(0xff80DEEA),
    ];
    int clrcnt = 0;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => NotePage(
                          isUpdate: false,
                        )));
          },
          backgroundColor: const Color(0xff252525),
          child: Icon(
            Icons.note_add,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff252525),
        appBar: AppBar(
          title: Text(
            'Notes',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              textStyle: const TextStyle(color: Colors.white, fontSize: 35),
            ),
          ),
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: const Color(0xff252525),
          actions: [
            IconButton(
              onPressed: () {
                QuickAlert.show(
                  backgroundColor: const Color(0xff252525),
                  textColor: Colors.white,
                  titleColor: Colors.white,
                  context: context,
                  type: QuickAlertType.warning,
                  text: 'Do you want to logout?',
                  confirmBtnText: 'Yes',
                  onConfirmBtnTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) {
                      FirebaseAuth.instance.currentUser!.delete();
                      FirebaseAuth.instance.signOut();
                      return SignInPage();
                    }));
                  },
                  cancelBtnText: 'No',
                  confirmBtnColor: const Color(0xff3B3B3B),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: (notesProvider.isLoading == false)
            ? SafeArea(
                child: notesProvider.notes.length > 0
                    ? Container(
                        margin: EdgeInsets.all(10),
                        child: ListView(children: [
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                searchQuery = val;
                              });
                            },
                            autofocus: false,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            maxLines: 1,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: const Color(0xff3B3B3B),
                              filled: true,
                              hintText: 'Search...',
                              hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
                                textStyle: const TextStyle(
                                    color: Colors.white54, fontSize: 20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: notesProvider
                                .getFilteredNotes(searchQuery)
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              Note gridNote = notesProvider
                                  .getFilteredNotes(searchQuery)[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => NotePage(
                                                isUpdate: true,
                                                note: gridNote,
                                              )));
                                },
                                onLongPress: () {
                                  QuickAlert.show(
                                    backgroundColor: const Color(0xff252525),
                                    textColor: Colors.white,
                                    titleColor: Colors.white,
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text: 'Do you want to delete the note?',
                                    confirmBtnText: 'Yes',
                                    onConfirmBtnTap: () {
                                      notesProvider.deleteNote(gridNote);
                                      Navigator.pop(context);
                                    },
                                    cancelBtnText: 'No',
                                    confirmBtnColor: const Color(0xff3B3B3B),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: (clrcnt == 5)
                                        ? clr[(clrcnt -= 5) == 0 ? 0 : 0]
                                        : clr[clrcnt++],
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: GridTile(
                                    header: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${gridNote.title}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w600,
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${gridNote.content}',
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w400,
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Text(''),
                                    footer: Text(
                                      '${gridNote.dateadded!.day.toString().padLeft(2, '0')}/${gridNote.dateadded!.month.toString().padLeft(2, '0')}/${gridNote.dateadded!.year.toString()}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ]),
                      )
                    : Center(
                        child: Text(
                          'No Notes Yet!',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 190, 189, 189),
                                fontSize: 20),
                          ),
                        ),
                      ))
            : Center(
                child: CircularProgressIndicator(color: Colors.white),
              ));
  }
}
