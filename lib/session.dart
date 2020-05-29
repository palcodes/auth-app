import 'package:flutter/material.dart';
import 'package:makestories_interview/ui/home.dart';
import 'package:makestories_interview/ui/login.dart';
import 'package:provider/provider.dart';
import 'package:makestories_interview/abstractions/user.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {

    // User login session management
    final user = Provider.of<User>(context);
    
    if( user == null ) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}