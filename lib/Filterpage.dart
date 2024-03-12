import 'package:studyhub/main.dart';
import 'package:flutter/material.dart';
import 'package:studyhub/profilePage.dart';


class FilterPageContent extends StatelessWidget {
  List<String> jenjang = [
      "Senior High School",
      "Under Graduate",
      "Graduate",
      "Working/Employee"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Filter Page"),
      backgroundColor: Colors.blue,
      leading: Icon(Icons.filter_tilt_shift_rounded, color: Colors.white,)
      ),

    );


}
}