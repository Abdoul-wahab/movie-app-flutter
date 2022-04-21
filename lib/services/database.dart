import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String firstname, String lastname, String city, String email) async {
    return await userCollection.doc(uid).set({'firstname': firstname, 'lastname': lastname, 'city': city, 'email': email});
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  UserData _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return UserData(
      uid: snapshot.id,
      firstname: data['firstname'],
      lastname: data['lastname'],
      city: data['city'],
      email: data['email'],
    );
  }

  Stream<UserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}