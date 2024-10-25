import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final double? width;

  const MyButton({super.key, required this.onTap, this.width, required String buttonText, required MaterialColor backgroundColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF004D40),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}
