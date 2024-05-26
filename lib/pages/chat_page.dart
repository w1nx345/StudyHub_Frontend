import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bubble/bubble.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

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
                context,
                MaterialPageRoute(builder: (context) => ProfilePageContent()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2023/08/24/19/58/saitama-8211499_1280.png'),
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
        backgroundColor: const Color(0xFF241E90),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF241DB2),
            padding: const EdgeInsets.all(5),
            child: Row(
              children:[
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.myanimelist.net/images/characters/5/525108.jpg'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Mr. Stark',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Chat(
              theme: const DefaultChatTheme(
                inputBackgroundColor: Color(0xFF241E90),
                backgroundColor: Color(0xFF2F27CE),
              ),
              bubbleBuilder: _bubbleBuilder,
              onAttachmentPressed: _handleImageSelection,
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubbleBuilder(
      Widget child, {
        required types.Message message,
        required bool nextMessageInGroup,
      }) {
    final isCurrentUser = _user.id == message.author.id;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.black : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isCurrentUser ? const Radius.circular(10) : const Radius.circular(0),
            bottomRight: isCurrentUser ? const Radius.circular(0) : const Radius.circular(10),
          ),
        ),
        child: child,
      ),
    );
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
