import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_hub/components/my_button.dart';
import 'package:learn_hub/components/my_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final storage = FlutterSecureStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) async {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'email': enteredEmail,
          'password': enteredPassword,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final accessToken = jsonData['access'];
        final refreshToken = jsonData['refresh'];
        final userId = jsonData['id'].toString();

        // Save token in local storage
        await storage.write(key: "access", value: accessToken);
        await storage.write(key: "refresh", value: refreshToken);
        await storage.write(key: "id", value: userId);

        print(accessToken); // For debugging purposes
        Navigator.pushNamed(context, '/search');
      } else if (response.statusCode == 401) {
        final jsonData = jsonDecode(response.body);
        print(jsonData); // For debugging purposes
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // Header text
            Text(
              'Login or sign up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Email text field
            MyTextField(
              controller: emailController,
              obscureText: false,
              width: 300,
              hintText: 'Username, email or mobile number',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Password text field
            MyTextField(
              controller: passwordController,
              obscureText: true,
              width: 300,
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Sign in button
            MyButton(
              onTap: () => signUserIn(context),
              width: 300,
              buttonText: 'Continue',
              backgroundColor: Colors.green,
            ),
            const SizedBox(height: 20),

            // Alternative sign up option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(thickness: 1.5, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Or',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 1.5, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Google sign-in button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'lib/images/google.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sign-up text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don’t have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/signup'); // Go to sign up page
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}