import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Settings", context: context, backButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            tile(Icons.person, "Login to Seller Account",
                () => Navigator.pushNamed(context, '/sellerLogin')),
            divider(),
            // tile(Icons.favorite, "Favourites", () => null),
            // divider(),
          ],
        ),
      ),
    );
  }

  Widget tile(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      contentPadding: const EdgeInsets.all(8),
    );
  }

  Widget divider() {
    return const Divider(
      height: 0,
      thickness: 1.5,
    );
  }
}
