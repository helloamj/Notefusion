import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './pages/home_page.dart';
import './pages/note_page.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './pages/authentication/sign_up_page.dart';
import './pages/authentication/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? HomePage()
            : SignInPage(),
      ),
    );
  }
}
