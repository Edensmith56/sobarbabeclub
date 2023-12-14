import 'package:dating_app/sobarbabe/sobertime.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../contoller/signupcontroller.dart';
import '../../models/user.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isChecked = false;
  bool isPasswordVisible = false;

  final controller = Get.put(SignUpController());
  final _fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundlites.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logonew.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  Image.asset(
                    'assets/images/alarmclock.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Form(
                      key: _fromkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.fullname,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 0.0,
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color(0xFFAB47BC), width: 1.5),
                              ),
                              fillColor:
                                  const Color.fromARGB(101, 158, 158, 158),
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(),
                            child: TextFormField(
                              controller: controller.email,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0.0,
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFAB47BC), width: 1.5),
                                ),
                                fillColor:
                                    const Color.fromARGB(101, 158, 158, 158),
                                filled: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Transform.translate(
                            offset: Offset(0, 0),
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: TextFormField(
                                controller: controller.password,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  prefixIconColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    gapPadding: 0.0,
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFAB47BC), width: 2),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(101, 158, 158, 158),
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !isPasswordVisible,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.pinkAccent, // Customize checkbox color when unchecked
                                  checkboxTheme: CheckboxThemeData(
                                    checkColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors.white; // Customize checkbox color when checked
                                        }
                                        else
                                        return Colors.black; // Default color
                                      },
                                    ),
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Color.fromARGB(
                                            255, 201, 36, 235);// Customize checkbox fill color when checked
                                        }
                                        return Colors.white; // Default color
                                      },
                                    ),
                                    overlayColor: MaterialStateProperty
                                        .all<Color>(Colors.white.withOpacity(
                                            0.1)), // Customize checkbox overlay color when pressed
                                  ),
                                ),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Privacy Policy link tap
                                },
                                child: Text(
                                  'I agree to the ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Privacy Policy link tap
                                },
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Text(
                                ' and ',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle Terms of Use link tap
                                },
                                child: Text(
                                  'Terms of Use',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (_fromkey.currentState!.validate()) {
                                      final user = UserModal(
                                        email: controller.email.text.trim(),
                                        password:
                                            controller.password.text.trim(),
                                        fullname:
                                            controller.fullname.text.trim(),
                                      );

                                      SignUpController.instance
                                          .createUser(user);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 60),
                                    textStyle: TextStyle(
                                      fontFamily: 'LEMONMILK',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors
                                        .pinkAccent, // Replace "Colors.blue" with your desired background color
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/loginletter.png', // Replace 'your_image.png' with the actual image asset path
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'REGISTER',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, 30),
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an Account?",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Login',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Sobertime(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
