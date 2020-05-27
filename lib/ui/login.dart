import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makestories_interview/ui/home.dart';
import 'package:makestories_interview/ui/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formState = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool success;

  void login() async {
    final FirebaseUser user = (await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;

    if (user != null) {
      success = true;
      print('LOGGED IN');
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } else {
      success = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 55, top: 40),
              child: Text('hello\nthere,',
                  style: GoogleFonts.lato(
                      fontSize: 85, fontWeight: FontWeight.w300))),
          Form(
            key: _formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 300,
                    margin: EdgeInsets.only(
                        top: 60, bottom: 10, right: 30, left: 30),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color.fromRGBO(70, 206, 206, 1),
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
                          labelStyle: GoogleFonts.lato(
                              fontSize: 12, fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(70, 206, 206, 1),
                              )),
                          focusColor: Color.fromRGBO(70, 206, 206, 1),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color.fromRGBO(70, 206, 206, 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(),
                          )),
                    )),
                Container(
                    width: 300,
                    margin: EdgeInsets.only(
                        top: 5, bottom: 10, right: 30, left: 30),
                    child: TextFormField(
                      cursorColor: Color.fromRGBO(70, 206, 206, 1),
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Enter your password',
                          labelStyle: GoogleFonts.lato(
                              fontSize: 12, fontWeight: FontWeight.w300),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(70, 206, 206, 1),
                              )),
                          focusColor: Color.fromRGBO(70, 206, 206, 1),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Color.fromRGBO(70, 206, 206, 1),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey[200]))),
                    )),
                Container(
                  margin:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                  width: 300,
                  height: 80,
                  child: RaisedButton(
                    onPressed: login,
                    color: Colors.white,
                    elevation: 0,
                    child: Text(
                      'Login',
                      style: GoogleFonts.lato(
                          fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                            color: Color.fromRGBO(70, 206, 206, 1), width: 3)),
                  ),
                )
              ],
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40, bottom: 15),
              child: Text('new here?',
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.w700))),
          Container(
            margin: EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 10),
            width: 280,
            height: 80,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SignUpScreen()));
              },
              color: Colors.white,
              elevation: 0,
              child: Text('Sign Up',
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.w400)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      color: Color.fromRGBO(70, 206, 206, 1), width: 3)),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
