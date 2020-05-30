import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makestories_interview/abstractions/auth.dart';
import 'package:makestories_interview/ui/home.dart';

// SignUp Slide Up on the Login Screen

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthService _authService = new AuthService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String nameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  String emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Email is mandatory';
    }
    return null;
  }

  String numberValidator(String value) {
    if (value.isEmpty) {
      return 'Phone number is mandatory';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length <= 6) {
      return 'Password should be more than 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 7),
            child: Text(
              'Tell us about you',
              style: GoogleFonts.workSans(
                  color: Color.fromRGBO(9, 68, 93, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            )),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 40),
                  child: TextFormField(
                    controller: nameController,
                    validator: nameValidator,
                    keyboardType: TextInputType.text,
                    cursorColor: Color.fromRGBO(9, 68, 93, 1),
                    decoration: InputDecoration(
                        labelText: 'Enter your name',
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
                          Icons.person,
                          color: Color.fromRGBO(9, 68, 93, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(),
                        )),
                  )),
              Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: emailController,
                    validator: emailValidator,
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
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: numberController,
                    validator: numberValidator,
                    keyboardType: TextInputType.number,
                    cursorColor: Color.fromRGBO(9, 68, 93, 1),
                    decoration: InputDecoration(
                        labelText: 'Enter your phone number',
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
                          Icons.call,
                          color: Color.fromRGBO(9, 68, 93, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(),
                        )),
                  )),
              Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    cursorColor: Color.fromRGBO(9, 68, 93, 1),
                    decoration: InputDecoration(
                        labelText: 'Enter your age',
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
                          Icons.assignment_turned_in,
                          color: Color.fromRGBO(9, 68, 93, 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(),
                        )),
                  )),
              Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: passwordController,
                    validator: passwordValidator,
                    keyboardType: TextInputType.text,
                    cursorColor: Color.fromRGBO(9, 68, 93, 1),
                    decoration: InputDecoration(
                        labelText: 'Enter a new password',
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
                          borderSide: BorderSide(),
                        )),
                  )),
              Container(
                margin:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                width: 350,
                height: 60,
                child: RaisedButton(
                  onPressed: () async {
                    AuthService().signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        numberController.text,
                        ageController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  color: Color.fromRGBO(9, 68, 93, 1),
                  elevation: 0,
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.workSans(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          color: Color.fromRGBO(9, 68, 93, 1), width: 3)),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    ageController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
