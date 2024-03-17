import 'package:flutter/material.dart';
import 'package:studyhub/pages/Filterpage.dart';
import 'package:studyhub/pages/profilePage.dart';
import 'package:studyhub/users/users_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person_pin, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePageContent()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_2_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterPageContent()),
              );
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Stack(
          children: users.map((user) {
            return Draggable(
              feedback: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Picture Icon
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      // User Info
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Age: ${user.age}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        user.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Learning Type: ${user.learningType}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Role: ${user.role}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Picture Icon
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      // User Info
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        'Age: ${user.age}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        user.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Learning Type: ${user.learningType}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Role: ${user.role}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              onDragEnd: (details) {
                if (details.offset.dx > 0) {
                  // Swiped right
                  setState(() {
                    users.removeLast();
                  });
                } else if (details.offset.dx < 0) {
                  // Swiped left
                  setState(() {
                    users.removeLast();
                  });
                }
              },
            );
          }).toList(),
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
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
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
