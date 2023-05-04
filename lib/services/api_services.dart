import 'dart:convert';

import 'package:notefusion/models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseURL = "https://filthy-sweatshirt-lion.cyclic.app/notes/";

  static Future<void> addNote(Note note) async {
    final url = Uri.parse(_baseURL + '/add');
    final response = await http.post(
      url,
      body: note.toMap(),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    final decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    final url = Uri.parse(_baseURL + '/delete');
    final response = await http.post(
      url,
      body: note.toMap(),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    final decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<List<Note>> fetchNodes({required String userId}) async {
    final url = Uri.parse(_baseURL + '/list');
    final response = await http.post(
      url,
      body: {'userid': userId},
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    final decoded = jsonDecode(response.body);
    print(decoded.toString());
    List<Note> notes = [];
    for (var x in decoded) {
      notes.add(Note.fromMap(x));
    }
    return notes;
  }
}
