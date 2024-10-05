
import 'package:cricklyzer/Screens/calculate_pace.dart';
import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:cricklyzer/Screens/learning_hub.dart';
import 'package:cricklyzer/Screens/statistics_screen.dart';
import 'package:cricklyzer/firebase_options.dart';
import 'package:cricklyzer/screens/learning_screens/cricket_basics.dart';
import 'package:cricklyzer/screens/splash_screen.dart';
import 'package:cricklyzer/themes/theme_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      // child: DevicePreview(
      //   builder: (context) => const MyApp(),
      // ),
      child: const MyApp(),
    ),
  );
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(
//     DevicePreview(
//       // enabled: !kReleaseMode, // Enable DevicePreview only in debug mode
//       builder: (context) => const MyApp(),
//     ),
//   );
// }


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
          fontFamily: 'Outfit'
      ),
      home: HomeScreen(),
      title: "Cricklyzer",
    );
  }
}




// SharedPreferences prefs = await SharedPreferences.getInstance();
























































// import 'package:cricklyzer/Screens/calculate_pace.dart';
// import 'package:cricklyzer/Screens/home_screen.dart';
// import 'package:cricklyzer/Screens/statistics_screen.dart';
// import 'package:cricklyzer/firebase_options.dart';
// import 'package:cricklyzer/screens/learning_screens/cricket_basics.dart';
// import 'package:cricklyzer/screens/splash_screen.dart';
// import 'package:device_preview/device_preview.dart'; // Import device_preview
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(DevicePreview(
//     // enabled: !kReleaseMode, // Enable only in debug mode
//     builder: (context) => const MyApp(), // Wrap the app with DevicePreview
//   ));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Cricklyzer",
//       theme: ThemeData(
//         fontFamily: 'Outfit',
//       ),
//       home: SplashScreen(),
//       // Add this to use DevicePreview
//       builder: DevicePreview.appBuilder,
//       locale: DevicePreview.locale(context), // Set the locale based on DevicePreview
//     );
//   }
// }
