// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'home_screen.dart';
// import 'welcome_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _isFirstTime = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkFirstTime().then((isFirstTime) {
//       setState(() {
//         _isFirstTime = isFirstTime;
//       });
//       _navigateToNextScreen();
//     });
//   }
//
//   // Future<bool> _checkFirstTime() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   return prefs.getBool('first_time') ?? true;
//   // }
//
//   Future<bool> _checkFirstTime() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       return prefs.getBool('first_time') ?? true;
//     } catch (e) {
//       print("Error accessing SharedPreferences: $e");
//       return true;
//     }
//   }
//
//   Future<void> _navigateToNextScreen() async {
//     await Future.delayed(const Duration(seconds: 3));
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => _isFirstTime ? const WelcomeScreen() : HomeScreen()),
//     );
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('first_time', false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/Cricklyzer-logo-2.png',
//               width: 120,
//               height: 120,
//             ),
//             const Text("Cricklyzer", style: TextStyle(fontSize: 30),),
//             const Text("App for Cricketers"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isFirstTime; // Set to nullable to handle uninitialized state

  @override
  void initState() {
    super.initState();
    _initApp(); // Initialize app state and navigation logic
  }

  Future<void> _initApp() async {
    await _checkFirstTime();
    await Future.delayed(const Duration(seconds: 3)); // Adding delay for splash screen effect

    // Navigate based on the first-time check result
    if (_isFirstTime != null) {
      _navigateToNextScreen();
    }
  }

  Future<void> _checkFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('first_time') ?? true; // Default to true

      if (isFirstTime) {
        await prefs.setBool('first_time', false); // Set flag to indicate first-time use is over
      }

      // Safely update the state
      setState(() {
        _isFirstTime = isFirstTime;
      });
    } catch (e) {
      print("Error accessing SharedPreferences: $e");
      // If error occurs, assume it's not the first time and proceed
      setState(() {
        _isFirstTime = false;
      });
    }
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _isFirstTime == true
            ? const WelcomeScreen() // Navigate to WelcomeScreen if first-time
            : HomeScreen(), // Otherwise navigate to HomeScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Cricklyzer-logo-2.png',
              width: 120,
              height: 120,
            ),
            const Text(
              "Cricklyzer",
              style: TextStyle(fontSize: 30),
            ),
            const Text("App for Cricketers"),
            if (_isFirstTime == null) // Show loading indicator while checking first-time status
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
