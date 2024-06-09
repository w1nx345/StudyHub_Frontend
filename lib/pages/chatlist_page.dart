import 'package:flutter/material.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/search_page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'package:learn_hub/pages/chat_page.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F27CE),
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfilePageContent()),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png'),
              radius: 30,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
          ),
        ],
        backgroundColor: Color(0xFF00796B),
      ),
      body: Container(
        color: Color(0xFF009688),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: Row(
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'Recent',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ChatItem(
                    avatar: 'https://cdn.myanimelist.net/images/characters/5/525108.jpg',
                    name: 'Mr. Stark',
                    message: 'Hm?... <(=~=)>',
                    time: 'Sent 1m ago',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage()),
                      );
                    },
                  ),
                  ChatItem(
                    avatar: 'https://cdn.idntimes.com/content-images/community/2024/03/magen-43da29a867d49c1f351ac6b665d26419-a2f4c889f446916252d865ae01a384c8.jpg',
                    name: 'Übel',
                    message: 'Let\'s play',
                    time: 'Sent 3h ago',
                  ),
                  ChatItem(
                    avatar: 'https://static.wikia.nocookie.net/frieren/images/3/30/Serie_anime_portrait.png',
                    name: 'Serie',
                    message: 'Sure',
                    time: 'Sent 10m ago',
                  ),
                  ChatItem(
                    avatar: 'https://static.wikia.nocookie.net/frieren/images/6/65/Fern_anime_portrait.png',
                    name: 'Fern',
                    message: 'I put it on the table',
                    time: 'Sent 10m ago',
                  ),
                ],
              ),
            ),
            BottomNavigationBar(
              backgroundColor: Color(0xFF00796B),
              items: [
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
                    Navigator.pushNamed(context, '/profile');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/search');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/settings');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/filter');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final VoidCallback? onTap;

  ChatItem({required this.avatar, required this.name, required this.message, required this.time, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: 30.0,
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0, fontFamily: 'OpenSans'),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}