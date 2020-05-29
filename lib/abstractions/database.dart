import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makestories_interview/abstractions/user.dart';

class DatabaseService {
  final String uid;
  final CollectionReference cref = Firestore.instance.collection('users');

  DatabaseService({this.uid});

  Stream<User> get userData {
    return cref.document(uid).snapshots().map((_doc) => User.fromFirestore(_doc));
  }

  Future<void> storeUserData (
      String name, String email, String number, String age) async {
    return await cref
        .document(uid)
        .setData({'name': name, 'email': email, 'number': number, 'age': age});
  }
}
