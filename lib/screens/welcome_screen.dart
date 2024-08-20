import 'package:flutter/material.dart';
import 'package:cricklyzer/widgets/custom_buttons.dart';
import 'package:cricklyzer/services/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/letter-c-outline.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "You Love Cricket?",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const Text(
                  "Start your journey with us",
                ),
                const SizedBox(height: 20),
                // Custom button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      // ap.isSignedIn
                      //     ? Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => HomeScreen(),
                      //         ),
                      //       )
                      // :
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    text: 'Let\'s Get Started',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
