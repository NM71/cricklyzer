import 'package:flutter/material.dart';

class Material3Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const Material3Button({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 80,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 252, 44, 29)),
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          elevation: WidgetStatePropertyAll<double>(5),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
