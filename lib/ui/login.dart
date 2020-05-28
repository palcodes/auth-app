import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makestories_interview/ui/home.dart';
import 'package:makestories_interview/ui/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

  PanelController panelController = new PanelController();

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
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(12.0),
      topRight: Radius.circular(12.0),
    );

    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: radius,
        parallaxEnabled: true,
        controller: panelController,
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        isDraggable: true,
        minHeight: 2,
        maxHeight: 550,
        panel: SignUpScreen(),
        body: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 25, top: 60),
                child: Text('Hello\nThere',
                    style: GoogleFonts.workSans(
                        color: Color.fromRGBO(9, 68, 93, 1),
                        fontSize: 85,
                        fontWeight: FontWeight.w500))),
            Form(
              key: _formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 350,
                      margin: EdgeInsets.only(
                          top: 140, bottom: 10, right: 30, left: 30),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color.fromRGBO(9, 68, 93, 1),
                        decoration: InputDecoration(
                            labelText: 'Enter your email',
                            labelStyle: GoogleFonts.workSans(
                                fontSize: 18, fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(9, 68, 93, 1),
                                )),
                            focusColor: Color.fromRGBO(9, 68, 93, 1),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Color.fromRGBO(9, 68, 93, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(),
                            )),
                      )),
                  Container(
                      width: 350,
                      margin: EdgeInsets.only(
                          top: 5, bottom: 10, right: 30, left: 30),
                      child: TextFormField(
                        cursorColor: Color.fromRGBO(9, 68, 93, 1),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Enter your password',
                            labelStyle: GoogleFonts.workSans(
                                fontSize: 18, fontWeight: FontWeight.w300),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(9, 68, 93, 1),
                                )),
                            focusColor: Color.fromRGBO(9, 68, 93, 1),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Color.fromRGBO(9, 68, 93, 1),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey[200]))),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 10),
                    width: 350,
                    height: 70,
                    child: RaisedButton(
                      onPressed: login,
                      color: Colors.white,
                      elevation: 0,
                      child: Text(
                        'Login',
                        style: GoogleFonts.workSans(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: Color.fromRGBO(9, 68, 93, 1), width: 3)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 5),
                    width: 350,
                    height: 70,
                    child: RaisedButton(
                      onPressed: () {
                        panelController.open();
                      },
                      color: Color.fromRGBO(9, 68, 93, 1),
                      elevation: 0,
                      child: Text('Sign Up',
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: Color.fromRGBO(9, 68, 93, 1), width: 3)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
