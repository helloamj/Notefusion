import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController cpasscontroller = TextEditingController();
  bool e = true, p = true, cp = true;
  void createAccount() async {
    String email = emailcontroller.text.trim();
    String pass = passcontroller.text.trim();
    String cpass = cpasscontroller.text.trim();
    if (email == "" || pass == "" || cpass == "") {
      setState(() {
        if (email == "") e = false;
        if (pass == "") p = false;
        if (cpass == "") cp = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter all the fields'),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (pass != cpass) {
      setState(() {
        if (pass == "") p = false;
        if (cpass == "") cp = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords are not matching'),
          duration: Duration(seconds: 4),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        if (userCredential.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Successfully created'),
              duration: Duration(seconds: 4),
            ),
          );
          Navigator.pop(context);
        }
        print('done');
      } on FirebaseAuthException catch (ex) {
        print(ex);
      }
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
                          color: (e) ? Colors.white54 : Colors.red,
                          fontSize: 20),
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
                          color: (p) ? Colors.white54 : Colors.red,
                          fontSize: 20),
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
                  controller: cpasscontroller,
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
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w300,
                      textStyle: TextStyle(
                          color: (cp) ? Colors.white54 : Colors.red,
                          fontSize: 20),
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
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      createAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Sign up',
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
                      'Already have an account? ',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign in',
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
