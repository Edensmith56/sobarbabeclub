import 'package:dating_app/sobarbabe/register.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../contoller/LoginController.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundlites.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/loginsugarlogo.png',
                width: 300.0,
                height: 300.0,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/alarmclock.png',
                width: 200.0,
                height: 200.0,
              ),
              SizedBox(
                height: 100,
                child: Transform.translate(
                  offset: Offset(0, 00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            70, 00, 00, 00), // Add your desired margin value
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Image.asset(
                            'assets/images/Signup.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Spacer(),
                      Transform.translate(
                        offset: Offset(-40, 00),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              00, 00, 00, 00), // Add your desired margin value
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Image.asset(
                              'assets/images/logins.png',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Transform.translate(
                  offset: Offset(-65, 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.all(10), // Add your desired margin value
                        child: Image.asset(
                          'assets/images/bear.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Spacer(),
                      Transform.translate(
                        offset: Offset(115, 00),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          // Add your desired margin value
                          child: Image.asset(
                            'assets/images/yocat.png',
                            width: 80,
                            height: 80,
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
    );
  }
}
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}






class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());

  bool isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgroundlites.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  'assets/images/logonew.png',
                  width: 300.0,
                  height: 300.0,
                ),
              ),
              Image.asset(
                'assets/images/alarmclock.png',
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: 50),
              Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                  child: TextFormField(
                    onChanged: (value) => controller.email.value = value,

                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIconColor: Colors.white,
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
                      fillColor: const Color.fromARGB(101, 158, 158, 158),
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: TextFormField(
                    onChanged: (value) => controller.password.value = value,

                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white),
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
                      fillColor: const Color.fromARGB(101, 158, 158, 158),
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
              SizedBox(height: 16),
              Transform.translate(
                offset: Offset(0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "             ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password action
                      },
                      child: const Text(
                        "Forgot Password ?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.login(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 60),
                        textStyle: const TextStyle(
                          fontFamily: 'LEMONMILK',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor:
                            Colors.pinkAccent, // Your desired background color
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/loginletter.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
              ),
              Container(
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the signup screen
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        children: [
                          TextSpan(
                            text: ' Signup',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
