import 'package:flutter/material.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selected = 0;

  List<Widget> screens = [
    DashboardMain(),
    Container(
      child: Text('Categories'),
    ),
    Container(
      child: Text('Setting'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selected],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppThemeShared.primaryColor,
          currentIndex: selected,
          onTap: (value) => setState(() {
                selected = value;
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_cozy), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ]),
    );
  }
}
