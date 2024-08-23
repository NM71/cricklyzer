
import 'package:cricklyzer/Screens/calculate_pace.dart';
import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:cricklyzer/Screens/statistics_screen.dart';
import 'package:cricklyzer/firebase_options.dart';
import 'package:cricklyzer/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Symthe'
      ),
      home: SplashScreen(),
      title: "Cricklyzer",
    );
  }
}


















// SharedPreferences prefs = await SharedPreferences.getInstance();
