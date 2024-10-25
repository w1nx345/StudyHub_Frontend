import 'package:flutter/material.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/search_page.dart';
import 'package:learn_hub/pages/splash_screen.dart';
import 'package:learn_hub/pages/settings_page.dart';
import 'package:learn_hub/pages/profile_page.dart';
import 'package:learn_hub/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      routes: {
        '/chatlist': (context) => const ChatListPage(),
        '/signup': (context) => const SignUpPage(title: 'Study Hub'),
        '/search': (context) => const SearchPage(),
        '/filter': (context) => const FilterPage(),
        '/profile': (context) => const ProfilePageContent(),
        '/settings': (context) => const SettingsPage(),
        '/filter': (context) => const FilterPage(),
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
