
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cricklyzer/Screens/home_screen.dart';
// // import 'package:cricklyzer/widgets/custom_buttons.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;
//
//   @override
//   void initState() {
//     super.initState();
//     _auth.authStateChanges().listen((event) {
//       setState(() {
//         _user = event;
//       });
//       if (_user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _user != null ? _userInfo() : _googleSignInButton(),
//     );
//   }
//
//   Widget _googleSignInButton() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: Image.asset(
//               'assets/images/Cricklyzer-logo-2.png',
//               height: 120,
//             ),
//           ),
//           const Text(
//             'Cricklyzer',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             textAlign: TextAlign.center,
//             '\nSign In with your Google Account',
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 20,),
//           ),
//           const SizedBox(height: 30,),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffcf2e2e),width: 3),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GestureDetector(
//                   onTap: handleGoogleSignIn,
//                   child: const Image(
//                 image: AssetImage('assets/images/google-logo.png'),
//                 height: 40,
//                 width: 40,
//               ),
//               ),
//             ),
//           ),
//           // CustomButton(
//           //   text: "Sign In with Google",
//           //   onPressed: handleGoogleSignIn,
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _userInfo() {
//     return const SizedBox();
//   }
//
//   void handleGoogleSignIn() async {
//     try {
//       GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
//       // await FirebaseAuth.instance.signInWithProvider(googleAuthProvider);
//       await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
//       // ignore: empty_catches
//     } catch (error) {}
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cricklyzer/Screens/home_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
      if (_user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/signin_bg-transformed.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/images/Cricklyzer-logo-2.png',
                height: 120,
              ),
            ),
            const Text(
              'Cricklyzer',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              '\nSign In with your Google Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffcf2e2e), width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: handleGoogleSignIn,
                  child: const Image(
                    image: AssetImage('assets/images/google-logo.png'),
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfo() {
    return const SizedBox();
  }

  void handleGoogleSignIn() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
      } else {
        final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await _auth.signInWithCredential(credential);
        }
      }
    } catch (error) {
      print('Error during Google sign in: $error');
    }
  }
}