import 'package:flutter/material.dart';
import 'package:learn_hub/components/my_button.dart';
import 'package:learn_hub/components/my_textfield.dart';
import 'package:learn_hub/components/square_tile.dart';
import 'package:learn_hub/users/users.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;
    
    String validEmail = 'jacky.suwandi@gmail.com';
    String validPassword = '123456';
    if (enteredEmail == validEmail && enteredPassword == validPassword) {
      // Successful login, navigate to the home screen or perform any other action
      return print('Login successful!');
      // You can navigate to another screen or perform any other action here
    } else {
      // Failed login, display an error message or perform any other action
      // You can display an error message to the user or perform any other action here
      return print('Invalid Email or Password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigoAccent[100],
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
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: 'OpenSans',
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

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

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
                            color: Colors.white),
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

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        color: Colors.white
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

