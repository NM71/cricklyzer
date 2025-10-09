import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:cricklyzer/Screens/statistics_screen.dart';
import 'package:cricklyzer/firebase_options.dart';
import 'package:cricklyzer/screens/cricket_news_screen.dart';
import 'package:cricklyzer/themes/theme_provider.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit'),
      home: const MainTabController(),
      title: "Cricklyzer",
    );
  }
}

class MainTabController extends StatefulWidget {
  const MainTabController({super.key});

  @override
  State<MainTabController> createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StatisticsScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChange,
            ),
          ),
        ],
      ),
    );
  }
}

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
