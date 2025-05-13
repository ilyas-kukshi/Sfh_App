import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/screens/category/view_categories.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/screens/settings.dart';
import 'package:sfh_app/screens/user/my_cart.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/app_life_cycle_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class BottomNav extends StatefulWidget {
  final int screen;
  const BottomNav({super.key, required this.screen});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  BannerAd? banner;
  int selected = 0;

  List<Widget> screens = [
    const DashboardMain(),
    const ViewCategories(),
    // const MyCart(),
    const Settings()
  ];

  final AppLifecycleService appLifecycleService = AppLifecycleService();

  @override
  void initState() {
    super.initState();
    // createBannerAd();
    selected = widget.screen;
    appLifecycleService.startObserving();
  }

  @override
  void dispose() {
    super.dispose();
    appLifecycleService.startObserving();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 600
          ? Scaffold(
              backgroundColor: AppThemeShared.primaryColor,
              body: Center(
                child: Text(
                    "This app is not available on Pc/laptop. Please use a mobile browser.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white)),
              ),
            )
          : Scaffold(
              body: screens[selected],
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // banner != null
                  //     ? SizedBox(height: 55, child: AdWidget(ad: banner!))
                  //     : const Offstage(),
                  BottomNavigationBar(
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: AppThemeShared.primaryColor,
                      unselectedLabelStyle: const TextStyle(color: Colors.red),
                      showUnselectedLabels: true,
                      currentIndex: selected,
                      onTap: (value) => setState(() {
                            selected = value;
                          }),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.view_cozy), label: "Categories"),
                        // BottomNavigationBarItem(
                        //     icon: Icon(Icons.shopping_bag), label: "My Cart"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.settings), label: "Settings")
                      ]),
                ],
              ),
            );
    });
  }

  createBannerAd() {
    try {
      banner = AdmobService().createBannerAd();
      setState(() {});
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
