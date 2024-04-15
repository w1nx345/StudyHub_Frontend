import 'package:flutter/material.dart';

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
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.settings, size: 40, color: Colors.white),
        backgroundColor: Colors.indigo[400],
      ),
      backgroundColor: Colors.indigoAccent[100],
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "Account Settings",
                fontFamily: 'Open Sans',
                children: [
                  const _CustomListTile(
                    title: "Account",
                    icon: Icons.person,
                    fontFamily: 'Open Sans',
                  ),
                  const _CustomListTile(
                    title: "Privacy & Security",
                    icon: Icons.lock,
                    fontFamily: 'Open Sans',
                  ),
                  const _CustomListTile(
                    title: "Premium",
                    icon: Icons.workspace_premium_rounded,
                    fontFamily: 'Open Sans',
                  ),
                ],
              ),
              _SingleSection(
                title: "App Settings",
                fontFamily: 'Open Sans',
                children: [
                  const _CustomListTile(
                    title: "Notification",
                    icon: Icons.notifications,
                    fontFamily: 'Open Sans',
                  ),
                  _CustomListTile(
                    title: "Chats",
                    icon: Icons.chat,
                    fontFamily: 'Open Sans',
                  ),
                  const _CustomListTile(
                    title: "Language",
                    icon: Icons.language_rounded,
                    fontFamily: 'Open Sans',
                  ),
                ],
              ),
              const _SingleSection(
                title: "Support",
                fontFamily: 'Open Sans',
                children: [
                  _CustomListTile(
                    title: "Support",
                    icon: Icons.support_agent_rounded,
                    fontFamily: 'Open Sans',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Logout button
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: InkWell(
    onTap: () {},
      child:  Container(
        margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        width: 106 * fem,
        height: 37 * fem,
        decoration: BoxDecoration(
          color: Color(0xffd9d9d9),
          borderRadius: BorderRadius.circular(8 * fem),
        ),
        child: Center(
          child: Text(
            'Log Out',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Open Sans',
            ),
          ),
        ),
      ),
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
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
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