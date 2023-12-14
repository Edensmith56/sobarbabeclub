import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/screens/splash_screen.dart';
import 'package:dating_app/sobarbabe/sobertime.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../exceptions/Texception.dart';
import '../exceptions/signup_email_failure.dart';

class AuthenticationRepositary extends GetxController {
  static AuthenticationRepositary get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => SplashScreen())
        : user.emailVerified
            ? Get.offAll(() => Sobertime())
            : Get.offAll(SplashScreen());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => Sobertime())
          : Get.offAll(() => SplashScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);

      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTIONS - ${ex.message}');
      throw ex;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Now you have access to the authenticated user's UID
      String uid = userCredential.user?.uid ?? '';

      // Fetch additional user data from Firestore
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;

      // You can access the user's data using userData['field_name']

      // Navigate to the user's dashboard or profile page
      // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(userData)));
    } catch (e) {
      print("Error logging in: $e");
    }
  }


  
// Function to fetch the current user's profile data
Future<Map<String, dynamic>> fetchUserProfileData() async {
  try {
    // Step 1: Get the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    // Step 2: Check if a user is signed in
    if (user != null) {
      // Step 3: Get the user's UID
      String uid = user.uid;

      // Step 4: Query Firestore to retrieve the user's profile data
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection("SobarUser").doc(uid).get();

      // Step 5: Check if the user document exists
      if (userSnapshot.exists) {
        // Step 6: Get the user data
        Map<String, dynamic> userData = userSnapshot.data()!;

        // Step 7: Return the user data
        return userData;
      } else {
        // Handle the case where the user document doesn't exist
        throw "User document does not exist";
      }
    } else {
      // Handle the case where no user is signed in
      throw "No user signed in";
    }
  } catch (error) {
    // Handle any errors that may occur
    print("Error fetching profile data: $error");
    throw error;
  }
}



  Future<void> logout() async => await _auth.signOut();
}
