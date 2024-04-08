import 'package:studyhub/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:studyhub/pages/profilePage.dart';
import 'package:studyhub/pages/search.dart';

class FilterPageContent extends StatefulWidget {
  @override
  State<FilterPageContent> createState() => _FilterPageContentState();
}

class _FilterPageContentState extends State<FilterPageContent> {
  String? selectedAcademicLevel;
  String? selectedRole;
  String? selectedSubject;
  String? selectedLanguage;

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

  List<String> subjects = [
    "Math", "Biology", "Coding", "Physics"
  ];

  List<String> languages = [
    "English", "Indonesia", "French", "Java"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Page", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        leading: Icon(Icons.filter_list, color: Colors.white,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 0,
          right: 20,
          bottom: 20,
        ),
        child: Center(
          child: Column(
            children: [
              Text("Academic Level:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: DropdownButton<String>(
                  value: selectedAcademicLevel,
                  items: academicLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAcademicLevel = value.toString();
                    });
                    print(selectedAcademicLevel);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              Text("Subject:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: DropdownButton<String>(
                  value: selectedSubject,
                  items: subjects.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSubject = value.toString();
                    });
                    print(selectedSubject);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              Text("Language:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  items: languages.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value.toString();
                    });
                    print(selectedLanguage);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              Text("Role:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: DropdownButton<String>(
                  value: selectedRole,
                  items: roles.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value.toString();
                    });
                    print(selectedRole);
                  },
                  isExpanded: true,
                  underline: SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.message, color: Colors.white),
              onPressed: () {
                // Nanti tambah fungsi
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
                // Nanti tambah fungsi
              },
            ),
          ],
        ),
      ),
    );
  }
}
