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
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    _navigateToNextScreen();
  }

  Future<void> _checkFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isFirstTime = prefs.getBool('first_time') ?? true;

      if (_isFirstTime) {
        await prefs.setBool('first_time', false);
      }
    } catch (e) {
      print("Error accessing SharedPreferences: $e");
    }
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => _isFirstTime ? const WelcomeScreen() : HomeScreen(),
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
          ],
        ),
      ),
    );
  }
}
