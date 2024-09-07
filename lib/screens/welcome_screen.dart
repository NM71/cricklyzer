import 'package:flutter/material.dart';
import 'package:cricklyzer/widgets/custom_buttons.dart';
import 'package:cricklyzer/services/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Get Started (Steyn).jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Cricklyzer-logo-2.png",
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You Love Cricket?",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                    ),
                  ),
                  const Text(
                    "Start your journey with us",
                    style: TextStyle(
                        color: Colors.white
                    ),
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
      ),
    );
  }
}
