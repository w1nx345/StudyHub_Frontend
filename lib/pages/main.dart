import 'package:flutter/material.dart';
import 'package:studyhub/pages/profilePage.dart'; // Import your filter page
import 'package:studyhub/pages/Filterpage.dart';
import 'package:studyhub/pages/search.dart'; // Import your profile page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(), // Specify the initial page as SearchPage
    );
  }
}