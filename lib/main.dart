import 'package:flutter/material.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/splash_screen.dart';
import 'package:learn_hub/pages/chat_Page.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'pages/login_page.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      routes: {
    '/chatlist': (context) => ChatListPage(),
    },
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChatPage(
//       )
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SettingsPage(
//           title: ('Settings'),
//         )
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FilterPageContent(),
//     );
//   }
// }