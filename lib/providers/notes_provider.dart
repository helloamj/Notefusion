import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/api_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  static String? deviceId = FirebaseAuth.instance.currentUser!.email;
  List<Note> notes = [];
  NotesProvider() {
    deviceId = FirebaseAuth.instance.currentUser!.email;
    fetchNote();
  }

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
    ApiServices.addNote(note);
  }

  List<Note> getFilteredNotes(String searchquery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchquery.toLowerCase()))
        .toList();
  }

  void updateNote(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[index] = note;
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int index =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(index);
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  // Future<String> func() async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();
  //   final deviceInfo = await deviceInfoPlugin.deviceInfo;
  //   final allInfo = deviceInfo.data;
  //   return allInfo.toString();
  // }

  void fetchNote() async {
    // deviceId = await func();
    print(deviceId);
    notes = await ApiServices.fetchNodes(userId: deviceId!);
    isLoading = false;
    notifyListeners();
  }
}
