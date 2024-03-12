import 'package:flutter/material.dart';
import 'package:studyhub/search.dart';


class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  String? selectedAcademicLevel;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person_pin, color: Colors.white),
        title: Text(
          "Profile Page",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture icon
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Text("Name:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("E-mail:"),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                    print(selectedAcademicLevel); // Print selected value
                  },
                  isExpanded: true,
                  underline: SizedBox(), // Remove the underline
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
                  items: roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value.toString();
                    });
                    print(selectedRole); // Print selected value
                  },
                  isExpanded: true,
                  underline: SizedBox(), // Remove the underline
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to save data here
                  // For example, you can print the selected values
                  print("Name: " + "Placeholder for name");
                  print("Email: " + "Placeholder for email");
                  print("Academic Level: " + selectedAcademicLevel!);
                  print("Role: " + selectedRole!);
                },
                child: Text("Save"),
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
