import 'package:flutter/material.dart';
import 'package:learn_hub/pages/filter_page.dart';
import 'package:learn_hub/pages/chatlist_page.dart';
import 'package:learn_hub/pages/login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = 1.0; // Adjust this value based on your requirements
    double ffem = 1.0; // Adjust this value based on your requirements

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",
          style: TextStyle(
              color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Icon(Icons.settings, size: 40, color: Colors.white),
        backgroundColor: Color(0xFF00796B),
      ),
      backgroundColor: Color(0xFF009688),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "Account Settings",
                fontFamily: 'OpenSans',
                children: [
                  const _CustomListTile(
                    title: "Account",
                    icon: Icons.person,
                    fontFamily: 'OpenSans',
                  ),
                  const _CustomListTile(
                    title: "Privacy & Security",
                    icon: Icons.lock,
                    fontFamily: 'OpenSans',
                  ),
                  const _CustomListTile(
                    title: "Premium",
                    icon: Icons.workspace_premium_rounded,
                    fontFamily: 'OpenSans',
                  ),
                ],
              ),
              _SingleSection(
                title: "App Settings",
                fontFamily: 'OpenSans',
                children: [
                  const _CustomListTile(
                    title: "Notification",
                    icon: Icons.notifications,
                    fontFamily: 'OpenSans',
                  ),
                  _CustomListTile(
                    title: "Chats",
                    icon: Icons.chat,
                    fontFamily: 'OpenSans',
                  ),
                  const _CustomListTile(
                    title: "Language",
                    icon: Icons.language_rounded,
                    fontFamily: 'OpenSans',
                  ),
                ],
              ),
              const _SingleSection(
                title: "Support",
                fontFamily: 'OpenSans',
                children: [
                  _CustomListTile(
                    title: "Support",
                    icon: Icons.support_agent_rounded,
                    fontFamily: 'OpenSans',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Logout button
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: 16.0, bottom: 70.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            child: Container(
              width: 106,
              height: 37,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF00796B),
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

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;
  final String? fontFamily;
  const _CustomListTile(
      {Key? key,
        required this.title,
        required this.icon,
        this.trailing,
        this.titleColor,
        this.iconColor = Colors.white,
        this.fontFamily,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: TextStyle(
          color: titleColor ?? Colors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white,),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color? titleColor;
  final String? fontFamily;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
    this.titleColor,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toString(),
            style:
            Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16,
            color: titleColor ?? Colors.white,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}