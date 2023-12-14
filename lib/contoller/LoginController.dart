import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/sobarbabe/sobertime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firestore_data.dart';

class LoginController extends GetxController {
  final ShowPassword = false.obs;

  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();

  final isGoogleLoading = false.obs;
  final isLoading = false.obs;

  final isFacebookLoading = false.obs;
  // final auth = AuthenticationRepositary.instance;
  final _auth = FirebaseAuth.instance;
  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Show a success Snackbar
      final snackBar = SnackBar(
        content: Text('You have logged in successfully!'),
        backgroundColor: Colors.green, // Set the background color
        // action: SnackBarAction(label: "Undo", onPressed: () {}),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

      Get.offAll(() => Sobertime());
    } catch (e) {
      // Show an error Snackbar
      final snackBar = SnackBar(
        content: Text('Login failed. Check your credentials.'),
        backgroundColor: Colors.red, // Set the background color
        action: SnackBarAction(label: "Ok", onPressed: () {}),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        // Now you have user data in the 'userData' map
      }
    } catch (e) {
      print("Login failed: $e");
    }
  }
}

