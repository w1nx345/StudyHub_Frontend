import 'package:flutter/material.dart';
import 'package:study_hub/components/my_button.dart';
import 'package:study_hub/components/my_textfield.dart';
import 'package:study_hub/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {
    String enteredEmail = emailController.text;
    String enteredPassword = emailController.text;
    // Add your sign-in logic here
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
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                width: 200,
              ),

              const SizedBox(height: 50),

              // or continue with
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

              const SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'If you haven’t any account?',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white ,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
