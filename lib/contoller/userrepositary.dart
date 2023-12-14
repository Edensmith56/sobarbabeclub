import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

class UserRepositary extends GetxController {
  static UserRepositary get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // createUser(UserModal user) async {
  //   await _db.collection("Users").add(user.toJson()).whenComplete(() {
  //     Get.snackbar(
  //       "Success",
  //       "your Account Has Been Created",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green.withOpacity(0.1),
  //       colorText: Colors.green,
  //     );
  //   }).catchError((error, Stack) {
  //     Get.snackbar(
  //       "Fail",
  //       "Something Went wrong. Try Again",
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red.withOpacity(0.1),
  //       colorText: Colors.red,
  //     );
  //     print("ERROR - $error");
  //   });
  // }

  Future<void> createUser(UserModal user) async {
    try {
      // Step 1: Create the user in Firebase Authentication
      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Step 2: Get the user's unique ID from Firebase Authentication
      String? userId = authResult.user?.uid;

      // Step 3: Store additional user data in Firestore using the obtained UID
      await _db.collection("SobarUser").doc(userId).set(user.toJson());

      // Step 4: Show a success message or perform other actions if needed
      Get.snackbar(
        "Success",
        "Your Account Has Been Created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      // Handle errors that may occur during authentication or Firestore write
      Get.snackbar(
        "Fail",
        "Something Went Wrong. Try Again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("ERROR - $error");
    }
  }

  /// Step 2 - Fetch All Users OR User details
  Future<UserModal> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("SobarUser").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModal.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModal>> allUser() async {
    final snapshot = await _db.collection("SobarUser").get();
    final userData =
        snapshot.docs.map((e) => UserModal.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModal user) async {
    await _db.collection("SobarUser").doc(user.id).update(user.toJson());
  }
}




// class UserRepository extends GetxController {
//   static UserRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   createUser(UserModal user) async {
//     await _db
//         .collection("Users")
//         .add(user.toJson())
//         .whenComplete(
//           () => Get.snackbar("Success", "You account has been created.",
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.green.withOpacity(0.1),
//               colorText: Colors.green),
//         )
//         .catchError((error, stackTrace) {
//       Get.snackbar("Error", "Something went wrong. Try again",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.redAccent.withOpacity(0.1),
//           colorText: Colors.red);
//       print(error.toString());
//     });
//   }
// }
