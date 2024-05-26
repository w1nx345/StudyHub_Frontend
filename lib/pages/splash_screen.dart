import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_hub/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F27CE),
      body: Center(
        child: Image.asset(
          'lib/images/Study Hub Logo.png',
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
