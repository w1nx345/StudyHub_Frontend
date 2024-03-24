import 'dart:html';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // text editing controllers
  final usernameController =TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController= TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // register user in method
  void registerUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[300],
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // logo
              const Icon(
                Icons.hub_outlined,

                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'STUDY HUB',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 60,
                  fontFamily: 'OpenSans',
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'REGISTER'
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 60,
                  fontFamily: 'openSans'
                ),
              ),

              const SizedBox(height: 25),

              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Container(
                      child: Text(
                        'Username :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
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
                        'E-mail :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // E-mail textfield
              MyTextField(
                controller: emailController,
                hintText: 'E-mail',
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
                        'Date of Birth :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700],
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
                controller: dateOfBirthController,
                hintText: 'Date of Birth',
                obscureText: false,
              ),

              const Sizedbox(height: 5),

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
                          color: Colors.grey[700],
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
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 5),

              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Container(
                      child: Text(
                        'Phone Number :',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey[700],
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
                controller: phoneNumberController,
                hintText: 'Phone Number',
                obscureText: false,
              ),

              const SizedBox(height: 5),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or Continue with',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
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

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        color: Colors.grey[700]
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
