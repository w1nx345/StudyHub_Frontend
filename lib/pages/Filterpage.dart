import 'package:studyhub/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:studyhub/pages/profilePage.dart';
import 'package:studyhub/pages/search.dart';


class FilterPageContent extends StatelessWidget {
  String? selectedAcademicLevel;
  String? selectedSubject;
  String? selectedLanguage;
  String? selectedRole;

  List<String> academicLevels = [
    'Senior High School',
    'Undergraduate',
    'Graduate',
    'Working/Employee',
  ];
  List<String> roles = [
    "Open To Learn",
    "Open to Teach",
    "Just Need A Friend",
  ];
  List<String> subject = [
    'Math' 'Biology' 'Coding' 'Physics' 'Literature'
  ];
  List<String> language = [
    'English' 'Indonesia' 'French'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Filter Page"),
      backgroundColor: Colors.blue,
      leading: Icon(Icons.filter_tilt_shift_rounded, color: Colors.white,)
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Academic Level"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                // child: DropdownButton<String>(
                //   value: selectedAcademicLevel,
                //   items: academicLevels.map((String level) {
                //     return DropdownMenuItem<String>(
                //       value: level,
                //       child: Text(level),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedAcademicLevel = value.toString();
                //     });
                //     print(selectedAcademicLevel); // Print selected value
                //   },
                //   isExpanded: true,
                //   underline: SizedBox(), // Remove the underline
                // ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.message, color: Colors.white),
              onPressed: () {
                // Add functionality for message icon here
              },
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Add functionality for settings icon here
              },
            ),
          ],
        ),
      ),
    );


}
}