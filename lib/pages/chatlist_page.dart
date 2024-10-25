import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/chat_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> convoList = [];
  final storage = const FlutterSecureStorage();
  String? userId;


  Future<void> fetchConversations(String userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/convo/list?id=$userId'));

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        setState(() {
          convoList = [];  // Jika respons kosong, set convoList sebagai list kosong
        });
        return;
      }
      setState(() {
        convoList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load conversations');
    }
  }


  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    userId = await storage.read(key: 'id');
    if (userId != null) {
      fetchConversations(userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F27CE),
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ProfilePageContent()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png'),
              radius: 30,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => const FilterPage()),
              );
            },
          ),
        ],
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Container(
        color: const Color(0xFF009688),
        child: Column(
          children: <Widget>[
            const Padding(
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
              child: ListView.builder(
                itemCount: convoList.length,
                itemBuilder: (context, index) {
                  var convo = convoList[index];
                  // Mengambil waktu dari pesan terakhir
                  return ChatItem(
                    avatar: convo['profilePicture'] ?? '',
                    name: convo['first_name'] ?? 'Unknown',
                    message: convo['last_message']['text'] ?? 'No message',
                    time: convo['last_message']['timestamp'] != null
                        ? timeago.format(DateTime.parse(convo['last_message']['timestamp']))
                        : 'No messages yet',

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            convoId: convo['convo_id'], // Mengirim convo_id ke ChatPage
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BottomNavigationBar(
              backgroundColor: const Color(0xFF00796B),
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

  const ChatItem({super.key, required this.avatar, required this.name, required this.message, required this.time, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatar), // Fixing the error by using NetworkImage
              radius: 30.0,
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0, fontFamily: 'OpenSans'),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
