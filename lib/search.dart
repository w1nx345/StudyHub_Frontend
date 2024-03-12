import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:studyhub/Filterpage.dart';
import 'package:studyhub/profilePage.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person_pin, color: Colors.white),
          onPressed: (){
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePageContent()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_2_outlined, color: Colors.white),
            onPressed: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => FilterPageContent()),
              );
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body:
      Container(
        // This container will fill the body and contain the swipeable widgets
        color: Colors.blue[200], // Background color of the container
        child: ListView(
          children: [
            // Example of a swipeable cell for a user
            SwipeActionCell(
              key: ValueKey("user_1"),
              trailingActions: <SwipeAction>[
                SwipeAction(
                  onTap: (CompletionHandler handler) async {
                    // Handle like action
                    handler(true);
                  },
                  color: Colors.green,
                  icon: Icon(Icons.thumb_up),
                ),
                SwipeAction(
                  onTap: (CompletionHandler handler) async {
                    // Handle dislike action
                    handler(true);
                  },
                  color: Colors.red,
                  icon: Icon(Icons.thumb_down),
                ),
              ],
              child: ListTile(
                title:
                Text("Jacky Suwandi"),
                subtitle: Text("Hello guys, I'm looking for a friend :)- 19"),
                // Add other user details here
              ),
            ),
            // Add more swipeable cells for other users as needed
          ],
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
