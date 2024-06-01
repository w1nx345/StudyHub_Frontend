import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/settings_page.dart';

class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  String? selectedRole;
  String? selectedSubjects;
  String? userId;
  String? selectedGender;
  String? selectedAcademicLevel;
  String? selectedLearningType;
  String? selectedStudyPlace;

  final List<String> roles = [
    "A Study Mate",
    "Someone To Teach",
    "Someone To Learn",
  ];

  final List<String> subjects = [
    "Math",
    "Biology",
    "Coding",
    "Physics",
    "Literature",
    "Law",
    "Accounting"
  ];

  final List<String> genders = ["Male", "Female", "Other"];

  final List<String> learningTypes = [
    "Visual Learner",
    "Read/Write Learner",
    "Auditory Learner",
    "Kinesthetic Learner",
    "Solitary Learner",
    "Naturalistic Learner",
    "Social Learner",
  ];

  final List<String> studyPlaces = [
    "Cafe",
    "Library",
    "Park",
    "Video Call",
    "Call"
  ];

  final List<String> academicLevels = [
    "Senior High School",
    "Undergraduate",
    "Master",
    "Doctorate",
    "Employee",
  ];

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final locationController = TextEditingController();
  final bioController = TextEditingController();
  final learningTypeController = TextEditingController();
  final studyPlaceController = TextEditingController();
  final academicLevelController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    userId = await storage.read(key: 'id');
    if (userId != null) {
      getUserData(userId!);
    }
  }

  Future<void> getUserData(String userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/profile?id=$userId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('User data: $data');
      setState(() {
        nameController.text = data['first_name'];
        emailController.text = data['email'];
        selectedRole = data['role'];
        selectedSubjects = data['matkul'];
        if (data['profileImageUrl'] != null) {
          _image = File(data['profileImageUrl']);
        }
        selectedGender = data['gender'];
        locationController.text = data['location'];
        bioController.text = data['bio'];
        selectedLearningType = data['learningType'];
        selectedStudyPlace = data['studyPlace'];
        selectedAcademicLevel = data['academicLevel'];
      });
    } else {
      print("No user data");
    }
  }

  Future<void> updateUserData() async {
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/updateProfile/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': userId,
        'first_name': nameController.text,
        'email': emailController.text,
        'role': selectedRole,
        'matkul': selectedSubjects,
        'gender': selectedGender,
        'location': locationController.text,
        'bio': bioController.text,
        'learningType': selectedLearningType,
        'studyPlace': selectedStudyPlace,
        'academicLevel': selectedAcademicLevel,
      }),
    );

    if (response.statusCode == 200) {
      getUserId();
    } else {
      print("Failed to update user data");
    }
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Color(0xFF241E90)),
          ),
        ),
        backgroundColor: Color(0xFF241E90),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(
                        'https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png',
                      ) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: getImage,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Saitama",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: 'OpenSans'),
                ),
                SizedBox(height: 10),
                _buildTextField("Name :", nameController),
                SizedBox(height: 10),
                _buildTextField("E-mail :", emailController),
                SizedBox(height: 10),
                _buildDropdown("Role :", roles, selectedRole, (value) {
                  setState(() {
                    selectedRole = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdown("I am learning this subject :", subjects, selectedSubjects, (value) {
                  setState(() {
                    selectedSubjects = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdown("Gender :", genders, selectedGender, (value) {
                  setState(() {
                    selectedGender = value;
                  });
                }),
                SizedBox(height: 10),
                _buildTextField("Location :", locationController),
                SizedBox(height: 10),
                _buildTextField("Bio :", bioController),
                SizedBox(height: 10),
                _buildDropdown("My Learning Type :", learningTypes, selectedLearningType, (value) {
                  setState(() {
                    selectedLearningType = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdown("Preferred Study Place :", studyPlaces, selectedStudyPlace, (value) {
                  setState(() {
                    selectedStudyPlace = value;
                  });
                }),
                SizedBox(height: 10),
                _buildDropdown("Academic Level :", academicLevels, selectedAcademicLevel, (value) {
                  setState(() {
                    selectedAcademicLevel = value;
                  });
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF241E90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF2F27CE),
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatListPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
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
            underline: SizedBox(), // Remove underline
            dropdownColor: Colors.grey[200],
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
