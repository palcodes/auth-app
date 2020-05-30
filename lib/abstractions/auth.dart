import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makestories_interview/abstractions/database.dart';
import 'package:makestories_interview/abstractions/user.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User object
  User _user(FirebaseUser user) {
    if (user != null) {
      return User(
        uid: user.uid,
      );
    } else {
      Fluttertoast.showToast(
          msg: "Couldn't find User",
          backgroundColor: Colors.white,
          fontSize: 12,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Color.fromRGBO(9, 68, 93, 1));
      return null;
    }
  }

  // Auth change User Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_user);
  }

  // Sign up with Email
  Future<User> signUp(String name, String email, String number, String password,
      String age) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      await DatabaseService().storeUserData(name, email, number, age);
      return _user(user);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "User couldn't be created, check fields",
          backgroundColor: Colors.white,
          fontSize: 12,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Color.fromRGBO(9, 68, 93, 1));
    }
  }

  // Sign in With Password
  Future<User> login(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return _user(user);
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          Fluttertoast.showToast(
              msg: "Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          Fluttertoast.showToast(msg: "Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          Fluttertoast.showToast(msg: "User with this email doesn't exist");
          break;
        case "ERROR_USER_DISABLED":
          Fluttertoast.showToast(
              msg: "User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          Fluttertoast.showToast(msg: "Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          Fluttertoast.showToast(
              msg: "Signing in with Email and Password is not enabled.");
          break;
        default:
          Fluttertoast.showToast(msg: "An undefined Error occured");
      }
    }
  }

  // Sign Out
  Future signOut() async {
    await _auth.signOut().catchError((e) => {print(e.toString())});
  }
}
