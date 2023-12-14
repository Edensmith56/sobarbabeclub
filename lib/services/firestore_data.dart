import 'package:cloud_firestore/cloud_firestore.dart';



final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

Future<void> addUserToFirestore(String uid, String email, String password, String phoneNo, String fullName) async {
  await usersCollection.doc(uid).set({
    'Email': email,
    'Password': password,
    'fullName': fullName,
  });
}

