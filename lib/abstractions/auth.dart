import 'package:firebase_auth/firebase_auth.dart';
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
  Future signUp() async {
    AuthResult authResult = await _auth
        .createUserWithEmailAndPassword(email: null, password: null)
        .catchError((e) => {print(e.toString())});
    FirebaseUser user = authResult.user;
    return user;
  }

  // Sign in With Password
  Future login() async {
    AuthResult authResult = await _auth
        .signInWithEmailAndPassword(email: null, password: null)
        .catchError((e) => {print(e.toString())});
    FirebaseUser user = authResult.user;
    return user;
  }
}
