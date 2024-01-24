import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/screens/category/view_categories.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/screens/settings.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  BannerAd? banner;
  int selected = 0;

  List<Widget> screens = [
    const DashboardMain(),
    const ViewCategories(),
    const Settings()
  ];

  @override
  void initState() {
    super.initState();
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selected],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          banner != null
              ? SizedBox(height: 55, child: AdWidget(ad: banner!))
              : const Offstage(),
          BottomNavigationBar(
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
        ],
      ),
    );
  }

  createBannerAd() {
    try {
      banner = AdmobService().createBannerAd();
      setState(() {});
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
