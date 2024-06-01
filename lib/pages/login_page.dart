import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_hub/components/my_button.dart';
import 'package:learn_hub/components/my_textfield.dart';
import 'package:learn_hub/components/square_tile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final storage = FlutterSecureStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': enteredEmail,
          'password': enteredPassword
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final accessToken = jsonData['access'];
        final refreshToken = jsonData['refresh'];

        await storage.write(key: "access", value: accessToken);
        await storage.write(key: "refresh", value: refreshToken);

        Navigator.pushNamed(context, '/chatlist');
      } else {
        final jsonData = jsonDecode(response.body);
        // Handle login error here (e.g., show a message to the user)
        throw Exception(jsonData);
      }
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      print('Error logging in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF2F27CE),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'images/Study Hub Logo.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 25),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      'E-mail :',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                controller: emailController,
                obscureText: false,
              ),
              const SizedBox(height: 5),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Container(
                      child: Text(
                        'Password :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => signUserIn(context),
                width: 200,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Sign Up Using',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'images/google.png'),
                  SizedBox(width: 25),
                  SquareTile(imagePath: 'images/facebook.png')
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If you haven’t any account?',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup'); // ke sign up page
                    },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
