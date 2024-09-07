// import 'package:flutter/material.dart';
// // import 'package:sign_in_button/sign_in_button.dart';
//
// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final  TextStyle style;
//   const CustomButton({super.key, required this.text, required this.onPressed, required this.style});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//           foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
//           backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
//           shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25.0)))),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
// import 'package:sign_in_button/sign_in_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(const Color(0xffffffff),),
          backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffcf2e2e),),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
