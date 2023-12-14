import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/sobarbabe/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class Sobertime extends StatefulWidget {
  @override
  _SobertimeState createState() => _SobertimeState();
}

class _SobertimeState extends State<Sobertime>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> userProfileData = {};

  @override
  void initState() {
    super.initState();
    _loadUserProfileData();
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    _startConfettiLoop(); // Start the confetti loop
  }

  Future<void> _loadUserProfileData() async {
    try {
      Map<String, dynamic> userData = await fetchUserProfileData();
      setState(() {
        userProfileData = userData;
      });
    } catch (error) {
      // Handle any errors that may occur during data loading
      print("Error loading user profile data: $error");
    }
  }

  ///calculation

  DateTime dt1 = DateTime.now(); // Current date and time
  DateTime dt2 =
      DateTime.now(); // Default value, will be updated based on input
  int yearsDiff = 0;

  int calculateYearsDifference(DateTime start, DateTime end) {
    int yearsDiff = start.year - end.year;
    if (start.month < end.month ||
        (start.month == end.month && start.day < end.day)) {
      yearsDiff--;
    }
    return yearsDiff;
  }

  late ConfettiController _controller;
  DateTime _selectedDate = DateTime.now(); // Initialize with the current date

///////date picker

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startConfettiLoop() {
    // Define a repeating timer that triggers the confetti effect every 2 seconds
    Timer.periodic(Duration(seconds: 2), (timer) {
      _controller.play();
    });
  }

  List<String> dataList = [];

  // Function to save calculated values into Firestore
  Future<void> saveCalculatedValues(
      String userId, int yearsDiff, int monthsDiff, int daysDiff) async {
    try {
      // Reference to the Firestore collection
      final CollectionReference calculatorCollection =
          FirebaseFirestore.instance.collection("calculator");

      // Add a new document with calculated values and user ID
      await calculatorCollection.doc(userId).set({
        'userId': userId,
        'days': daysDiff,
        'months': monthsDiff,
        'years': yearsDiff,
      });

      print("Calculated values saved successfully.");
    } catch (error) {
      // Handle any errors that may occur during data saving
      print("Error saving calculated values: $error");
    }
  }

  // Function to handle date selection
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;

        // Calculate the values
        int yearsDiff = calculateYearsDifference(DateTime.now(), _selectedDate);
        int monthsDiff =
            (yearsDiff * 12) + _selectedDate.month - DateTime.now().month;
        int daysDiff = DateTime.now().difference(_selectedDate).inDays;

        // Get the current user's ID
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userId = user.uid;

          // Call the function to save the calculated values
          saveCalculatedValues(userId, yearsDiff, monthsDiff, daysDiff);
        } else {
          // Handle the case where no user is signed in
          print("No user signed in.");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration diff = dt1.difference(_selectedDate);
    int daysDiff = diff.inDays;
    int yearsDiff = calculateYearsDifference(dt1, _selectedDate);
    int remainingDays = daysDiff - (yearsDiff * 365);
    int monthsDiff = (yearsDiff * 12) + _selectedDate.month - dt1.month;

    dataList = [
      '$yearsDiff YEARS',
      '$monthsDiff MONTHS',
      '$daysDiff DAYS',
    ];

    Future<void> saveCalculatedValues(
        String userId, int yearsDiff, int monthsDiff, int daysDiff) async {
      try {
        // Reference to the "calculator" collection for the current user
        CollectionReference calculatorCollection =
            FirebaseFirestore.instance.collection("calculator");

        // Create a new document with a unique ID
        await calculatorCollection.add({
          "userId": userId, // Add the user's ID for reference
          "years": yearsDiff, // Store years in a "years" field
          "months": monthsDiff, // Store months in a "months" field
          "days": daysDiff, // Store days in a "days" field
          "timestamp": FieldValue.serverTimestamp(), // Add a timestamp
        });
      } catch (error) {
        // Handle any errors that may occur
        // ignore: avoid_print
        print("Error saving calculated values: $error");
        rethrow;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(232, 206, 100, 255),
        toolbarHeight: 55.0,
        titleSpacing: 36.0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Sober Babe Profile',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: 'Mulish',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_sharp),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
        ],
      ),
      endDrawer: Container(
        margin: const EdgeInsets.only(
          top: 30.0,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
          ),
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    // Transform.translate(
                    //   offset: Offset(25, 0),
                    //   child: Text(
                    //     '${userProfileData['mail']}',
                    //     style: TextStyle(
                    //       fontFamily: 'Mulish',
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 10),
                    Transform.translate(
                      offset: Offset(160, 05),
                      // child: CircleAvatar(
                      //   // Replace with your user's profile image
                      //   backgroundImage:
                      //       AssetImage('assets/bellacollection/lunagreen2.png'),
                      //   radius: 25,
                      // ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(
                    'My Profile',
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Color.fromARGB(232, 206, 100, 255)),
                ),
                GestureDetector(
                  onTap: () {
                    // Perform the desired action to switch screens here
                    // For example, you can use Navigator to push a new screen onto the stack
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ProfileinfoPage()),
                    // );
                  },
                  child: ListTile(
                    title: Text(
                      'Personal Info ',
                      style: const TextStyle(
                        fontFamily: 'Mulish',
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right,
                        color: Color.fromARGB(232, 206, 100, 255)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Perform the desired action to switch screens here
                    // For example, you can use Navigator to push a new screen onto the stack
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => ChangePasswordPage()),
                    // );
                  },
                  child: ListTile(
                    title: Text(
                      'Change Password',
                      style: const TextStyle(
                        fontFamily: 'Mulish',
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right,
                        color: Color.fromARGB(232, 206, 100, 255)),
                  ),
                ),
                // ListTile(
                //   title: Text(
                //     'Notification',
                //     style: const TextStyle(
                //       fontFamily: 'Mulish',
                //       color: Colors.black,
                //     ),
                //   ),
                //   trailing: Icon(Icons.chevron_right,
                //       color: Color.fromARGB(232, 206, 100, 255)),
                // ),
                ListTile(
                  title: Text(
                    'Legal',
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Color.fromARGB(232, 206, 100, 255)),
                ),
                ListTile(
                  title: Text(
                    'Languages',
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Color.fromARGB(232, 206, 100, 255)),
                ),
                ListTile(
                  title: Text(
                    'Privacy Policy',
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Color.fromARGB(232, 206, 100, 255)),
                ),
                ListTile(
                  title: Text(
                    'Terms and Conditions',
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Color.fromARGB(232, 206, 100, 255)),
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();

                    // Navigate to Login screen and remove all previous routes
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Login()), // Navigate to Login screen
                      (Route<dynamic> route) =>
                          false, // Remove all previous routes
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: const TextStyle(
                        fontFamily: 'Mulish',
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.logout,
                        color: Color.fromARGB(232, 206, 100, 255)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/purplebackgroundlites.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          Lottie.asset(
            'assets/lottiefiles/heart.json',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/images/logonew.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: 380.0,
                      child: TyperAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "   Hi! I'm your Soberiety Counter",
                        ],
                        textStyle: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "LEMONMILK",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 270,
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.asset(
                          'assets/images/wavealarm.png',
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0.0),
                      child: SizedBox(
                        width: 280.0,
                        height: 210.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.transparent,
                              width: 4.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              'assets/images/sobertime.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              width: 200,
                                              height: 120,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: dataList.length,
                                                itemBuilder: (context, index) {
                                                  return Transform.translate(
                                                    offset: Offset(0.0, 0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              05.0),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 0.5,
                                                            ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          dataList[index],
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'LEMONMILK',
                                                            color: Colors.black,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 280,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/soberbabeseen.png',
                            width: 200,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 5),
                          TextButton(
                            onPressed: _selectDate,
                            child: Text(
                              _selectedDate.toString().split(' ')[0],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 24, 22, 22),
                                fontFamily: 'LEMONMILK',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
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
          await FirebaseFirestore.instance.collection("Users").doc(uid).get();

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
