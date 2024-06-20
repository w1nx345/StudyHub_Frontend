import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_hub/components/my_button.dart';
import 'package:learn_hub/components/my_textfield.dart';
import 'package:learn_hub/components/square_tile.dart';
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
          'password': enteredPassword
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final accessToken = jsonData['access'];
        final refreshToken = jsonData['refresh'];
        final userId = jsonData['id'].toString();

        //save token di local storage
        await storage.write(key: "access", value: accessToken);
        await storage.write(key: "refresh", value: refreshToken);
        await storage.write(key: "id", value: userId);

        print(accessToken); // buat liat apakah dapet token nanti diapus
        Navigator.pushNamed(context, '/search');
      } else if (response.statusCode == 401){
        final jsonData = jsonDecode(response.body);
        print(jsonData); // jangan lupa diapus
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF009688),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // logo
              Image.asset(
                'lib/images/Study Hub Logo.png',
                height: 250,
                width: 250,
              ),

              const SizedBox(height: 50),

              const Column(
                children: <Widget>[
                  SizedBox(
                    width: 300,
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

              // E-mail textfield
              MyTextField(
                controller: emailController,
                obscureText: false,
                width: 300,
              ),

              const SizedBox(height: 5),

              const Column(
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 40,
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
                ],
              ),

              // password textfield
              MyTextField(
                controller: passwordController,
                obscureText: true,
                width: 300,
              ),

              const SizedBox(height: 10),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () => signUserIn(context),
                width: 200,
              ),

              const SizedBox(height: 50),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
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

              // google sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // facebook button
                  SquareTile(imagePath: 'lib/images/facebook.png')
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
        ]),
            ],
          ),
        ),
      ),
    );
  }
}
