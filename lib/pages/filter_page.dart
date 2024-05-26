import 'package:flutter/material.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FilterPage(),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> academicLevels = [
      'Senior High School',
      'Undergraduate',
      'Master',
      'Doctorate',
      'Employee',
    ];

    List<String> roles = [
      "A Study Mate",
      "Someone To Teach",
      "Someone To Learn",
    ];

    List<String> subjects = [
      "Math", "Biology", "Coding", "Physics", "Literature", "Law", "Accounting"
    ];

    List<String> languages = [
      "English", "Indonesia", "French", "Java"
    ];

    List<String> Gender = [
      "Male", "Female", "Other"
    ];

    List<String> StudyPlace = [
      "Cafe", "Library", "Park", "Video Call", "Call"
    ];

    List<String> LearningType = [
      "Visual Learner", "Read/Write Learner", "Auditory Learner", "Kinesthetic Learner", "Solitary Learner", "Naturalistic Learner", "Social Learner"
    ];

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
              FilterDropdown(label: 'Jenjang', items: academicLevels),
              SizedBox(height: 20),
              FilterDropdown(label: 'Subject', items: subjects),
              SizedBox(height: 20),
              FilterDropdown(label: 'Language', items: languages),
              SizedBox(height: 20),
              FilterDropdown(label: 'Role', items: roles),
              SizedBox(height: 20),
              FilterDropdown(label: 'Gender', items: Gender),
              SizedBox(height: 20),
              FilterDropdown(label: 'Study Place', items: StudyPlace),
              SizedBox(height: 20),
              FilterDropdown(label: 'Learning Type', items: LearningType),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 106,
                  height: 37,
                  child: ElevatedButton(
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
}

class FilterDropdown extends StatelessWidget {
  final String label;
  final List<String> items;

  const FilterDropdown({super.key, required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label :',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            items: items
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
                .toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
