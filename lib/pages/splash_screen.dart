import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_hub/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_hub/pages/search_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final storage = FlutterSecureStorage();

  Future<void> checkToken() async {
    final accessToken = await storage.read(key: "access");
    final refreshToken = await storage.read(key: "refresh");
    if (accessToken != null && refreshToken != null) {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/api/token/validate/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
          });
      print('Token: $accessToken');
      if (response.statusCode == 200) { // token valid
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      } else { // access token invalid, coba pake refresh token buat dapet access token baru
        print('Token: $accessToken');
        final responseRefreshToken = await http.post(
            Uri.parse('http://10.0.2.2:8000/api/token/refresh/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String>{'refresh': refreshToken}),
          );
        if (responseRefreshToken.statusCode == 200) { // token valid
          final jsonData = jsonDecode(responseRefreshToken.body);
          final newAccessToken = jsonData['access_token'];
          await storage.write(key: "access", value: newAccessToken);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        } else { // refresh tokennya ga valid juga
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      }
    } else { // ini kalo ga ada token dari awal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
    @override
    void initState() {
      super.initState();
      Future.delayed(const Duration(milliseconds: 1000), () {
        Future.delayed(const Duration(seconds: 3), () {
          checkToken();
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF00796B),
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
