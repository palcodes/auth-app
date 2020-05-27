import 'package:flutter/material.dart';
import 'package:makestories_interview/ui/home.dart';
import 'package:makestories_interview/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makestories_interview/ui/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        )
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            bool isLoggedIn = snapshot.hasData;
            if (isLoggedIn) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }
          else {
            return Container();
          }
        },
      ),
    );
  }
}
