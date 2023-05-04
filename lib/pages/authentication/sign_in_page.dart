import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:notefusion/pages/home_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool e = true, p = true, cp = true;
  void login() async {
    String email = emailcontroller.text.trim();
    String pass = passcontroller.text.trim();
    if (email == "" || pass == "") {
      setState(() {
        if (email == "") e = false;
        if (pass == "") p = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter all the fields'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (userCredential.user != Null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.code.toString()),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/iconol.png',
                ),
                TextField(
                  controller: emailcontroller,
                  autofocus: false,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  maxLines: 1,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: const Color(0xff3B3B3B),
                    filled: true,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      textStyle: TextStyle(
                          color: (e) ? Colors.white : Colors.red, fontSize: 20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passcontroller,
                  autofocus: false,
                  obscureText: true,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  maxLines: 1,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: const Color(0xff3B3B3B),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      textStyle: TextStyle(
                          color: (p) ? Colors.white : Colors.red, fontSize: 20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Sign in',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        'Sign up',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
