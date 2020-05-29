import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String age;
  String email;
  String number;
  Timestamp created;

  User({this.uid, this.name, this.age, this.email, this.number, this.created});

}
