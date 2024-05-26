import 'package:flutter/material.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  String? selectedRole;
  String? selectedSubjects;

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

  final nameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");

  File? _image;

  final ImagePicker _picker = ImagePicker();

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
        child : CircleAvatar(
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
                _buildDropdown("Subject :", subjects, selectedSubjects,
                        (value) {
                      setState(() {
                        selectedSubjects = value;
                      });
                    }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Perform filter action
                  },
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