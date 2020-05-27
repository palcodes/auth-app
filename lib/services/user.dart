import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String age;
  String email;
  String number;
  Timestamp created;

  User({this.uid, this.name, this.age, this.email, this.number, this.created});

  factory User.fromFirestore(DocumentSnapshot _doc) {
    Map _data = _doc.data;
    return User(
        uid: _doc.documentID,
        name: _data['name'],
        email: _data['email'],
        number: _data['number'],
        age: _data['age'],
        created: _data['created']);
  }

  factory User.fromMap(Map _data) {
    return User(
        uid: _data['id'],
        name: _data['name'],
        email: _data['email'],
        number: _data['number'],
        age: _data['age'],
        created: _data['created']);
  }
}
