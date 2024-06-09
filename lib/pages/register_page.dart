import 'package:flutter/material.dart';
import 'package:learn_hub/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _dateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  Future<void> _dateTime() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime(2045),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
  void userRegister(BuildContext context) async{
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;
    String enteredDOB = _dateController.text;

    try{
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
          body: jsonEncode(<String, String>{
          'email': enteredEmail,
          'password': enteredPassword,
          'birth_date': enteredDOB,
          }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final id = jsonData['id'].toString();
        await storage.write(key: "id", value: id);

        Navigator.push( // ke login page klo berhasil register
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        print('Failed to register'); // klo bukan 201 responsenya print ini
      }
    } catch (e){
      print('Error signup: $e'); // ini klo ga bisa connect ke server backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00796B),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 152.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/Study Hub Logo.png'),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      obscureText: false,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'E-mail :',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-ExtraBold"),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _dateController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Date of Birth :',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-ExtraBold"),
                        filled: false,
                        prefixIcon:
                        Icon(Icons.calendar_today, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _dateTime();
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password :',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans-ExtraBold"),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        userRegister(context);
                      },
                      child: const Text("Join Now"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF009688)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
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