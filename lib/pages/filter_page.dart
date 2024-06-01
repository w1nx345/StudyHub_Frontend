import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final storage = FlutterSecureStorage();
  final genderController = TextEditingController();
  final locationController = TextEditingController();
  final bioController = TextEditingController();
  final learningTypeController = TextEditingController();
  final studyPlaceController = TextEditingController();
  final academicLevelController = TextEditingController();
  final ageController = TextEditingController(); // New age controller

  String? selectedRole;
  String? selectedSubjects;
  String? userId;
  String? selectedGender;
  String? selectedAcademicLevel;
  String? selectedLearningType;
  String? selectedStudyPlace;

  Future<void> userFilter() async {
    userId = await storage.read(key: 'id');
    if (userId != null) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/filter/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': userId,
          'preferences': [
            {
              'gender': selectedGender,
              'role': selectedRole,
              'subject': selectedSubjects,
              'academicLevel': selectedAcademicLevel,
              'studyPlace': selectedStudyPlace,
              'learningType': selectedLearningType,
              'age': ageController.text, // Send age to backend
            },
          ],
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);

        final prefs = await SharedPreferences.getInstance();

        final userPreferences = jsonData['preferences'] as List;

        for (var preference in userPreferences) {
          final role = preference['role'];
          final gender = preference['gender'];
          final age = preference['age'];
          final academicLevel = preference['academicLevel'];
          final studyPlace = preference['studyPlace'];
          final learningType = preference['learningType'];
          final matkul = preference['matkul'];

          prefs.setString('role', role);
          prefs.setString('gender', gender);
          prefs.setInt('age', age);
          prefs.setString('academicLevel', academicLevel);
          prefs.setString('studyPlace', studyPlace);
          prefs.setString('learningType', learningType);
          prefs.setString('matkul', matkul);
        }

        print('User preferences stored successfully.');
      } else {
        print('Error saving user preferences: ${response.statusCode}');
        print(response.body);
      }
    }
  }

  final List<String> academicLevels = [
    'Senior High School',
    'Undergraduate',
    'Master',
    'Doctorate',
    'Employee',
  ];

  final List<String> roles = [
    "A Study Mate",
    "Someone To Teach",
    "Someone To Learn",
  ];

  final List<String> subjects = [
    "Math", "Biology", "Coding", "Physics", "Literature", "Law", "Accounting"
  ];

  final List<String> Gender = [
    "Male", "Female", "Other"
  ];

  final List<String> StudyPlace = [
    "Cafe", "Library", "Park", "Video Call", "Call"
  ];

  final List<String> LearningType = [
    "Visual Learner", "Read/Write Learner", "Auditory Learner", "Kinesthetic Learner", "Solitary Learner", "Naturalistic Learner", "Social Learner"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter Page',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Color(0xFF241E90),
        leading: Icon(
          color: Colors.white,
          Icons.filter_alt_rounded,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF2F27CE),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildDropdown("Gender :", Gender, selectedGender, (value) {
                setState(() {
                  selectedGender = value;
                });
              }),
              SizedBox(height: 20),
              _buildDropdown("Subject :", subjects, selectedSubjects, (value) {
                setState(() {
                  selectedSubjects = value;
                });
              }),
              SizedBox(height: 20),
              _buildDropdown("Role :", roles, selectedRole, (value) {
                setState(() {
                  selectedRole = value;
                });
              }),
              SizedBox(height: 20),
              _buildDropdown("Academic Level :", academicLevels, selectedAcademicLevel, (value) {
                setState(() {
                  selectedAcademicLevel = value;
                });
              }),
              SizedBox(height: 20),
              _buildDropdown("Study Place :", StudyPlace, selectedStudyPlace, (value) {
                setState(() {
                  selectedStudyPlace = value;
                });
              }),
              SizedBox(height: 20),
              _buildDropdown("Learning Type :", LearningType, selectedLearningType, (value) {
                setState(() {
                  selectedLearningType = value;
                });
              }),
              SizedBox(height: 20),
              _buildTextField("Age :", ageController),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 106,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: userFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF241E90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF241E90),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: '',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/chatlist');
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedItem,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: DropdownButton<String>(
            value: selectedItem,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            underline: SizedBox(),
            dropdownColor: Colors.grey[200],
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
