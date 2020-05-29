import 'package:flutter/material.dart';
import 'package:makestories_interview/abstractions/auth.dart';
import 'package:makestories_interview/abstractions/user.dart';
import 'package:makestories_interview/session.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Session(),
      ),
    );
  }
}
