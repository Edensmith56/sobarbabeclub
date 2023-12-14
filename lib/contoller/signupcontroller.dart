import 'package:dating_app/contoller/userrepositary.dart';
import 'package:dating_app/sobarbabe/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import 'authentication.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final userRepo = Get.put(UserRepositary);

  get userData => null;

  //Call these Functions from Design & they will do the logic
  void registerUser(String email, String password) {
    String? error = AuthenticationRepositary.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
        final snackBar = SnackBar(
        content: Text('something went wrong'),
        backgroundColor: Colors.red, // Set the background color
        action: SnackBarAction(label: "Ok", onPressed: () {}),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<void> createUser(UserModal user) async {
    UserRepositary userRepo = UserRepositary();
    await userRepo.createUser(user);
    Get.to(() => Login());
  }
}
