import 'package:firebase_auth/firebase_auth.dart';
import 'package:makestories_interview/abstractions/database.dart';
import 'package:makestories_interview/abstractions/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User object
  User _user(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
          )
        : "Couldn't find user";
  }

  // Auth change User Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_user);
  }

  // Sign up with Email
  Future<User> signUp(String name, String email, String number, String password,
      String age) async {
    AuthResult authResult = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) => {print(e.toString())});
    FirebaseUser user = authResult.user;
    await DatabaseService().storeUserData(name, email, number, age);
    return _user(user);
  }

  // Sign in With Password
  Future<User> login(String email, String password) async {
    AuthResult authResult = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) => {print(e.toString())});
    FirebaseUser user = authResult.user;
    return _user(user);
  }

  // Sign Out
  Future signOut() async {
    await _auth.signOut().catchError((e) => {print(e.toString())});
  }
}
