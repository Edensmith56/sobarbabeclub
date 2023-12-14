import 'package:cloud_firestore/cloud_firestore.dart';

//////////////////
///////Todo Section
///////////////////
class UserModal {
  final String? id;
  final String email;
  final String fullname;
  final String password;

  const UserModal({
    this.id,
    required this.email,
    required this.fullname,
    required this.password,
  });

  toJson() {
    return {
      "Email": email,
      "fullname": fullname,
      "Password": password,
    };
  }

  
 factory UserModal.fromSnapshot(DocumentSnapshot snapshot) {
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  return UserModal(
    id :snapshot.id??'',
    email: data['Email'] ?? '',
    password: data['Password'] ?? '',
    fullname: data['fullname'] ?? '',
  );
}

}