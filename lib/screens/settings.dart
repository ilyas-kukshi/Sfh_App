import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  String? token;
  UserModel? userProfile;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    token = await Utility().getStringSf("token");
  }

  logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Settings",
          context: context,
          backButton: false,
          textStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      body: FutureBuilder(
          future: getToken(),
          builder: (context, snapshot) {
            if (token != null) {
              final user = ref.watch(getUserByTokenProvider(token!));
              return user.when(
                data: (data) {
                  if (data != null) {
                    userProfile = data;
                    return functions(
                        false, data.role == Constants.user, true, true, true);
                  } else {
                    return const Text(
                        "Could not find a user on a given credentials, Please Login again.");
                  }
                },
                error: (error, stackTrace) => const Offstage(),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            } else {
              return functions(true, true, false, false, false);
            }
          }),
    );
  }

  Widget functions(
      bool login, bool sellerLogin, wishlist, bool orders, bool logout) {
    return SingleChildScrollView(
      child: Column(
        children: [
          login
              ? tile(
                  Icons.login,
                  "Login",
                  () =>
                      Navigator.pushNamed(context, '/login', arguments: token))
              : const Offstage(),
          wishlist
              ? tile(
                  Icons.favorite_outline_outlined,
                  "Wishlist",
                  () => Navigator.pushNamed(context, '/wishlist',
                      arguments: token))
              : const Offstage(),
          divider(),
          // orders
          //     ? tile(
          //         Icons.inventory_2,
          //         "Orders",
          //         () =>
          //             Navigator.pushNamed(context, '/orders', arguments: token))
          //     : const Offstage(),
          divider(),
          sellerLogin
              ? tile(Icons.person, "Switch to Seller Account",
                  () => Navigator.pushNamed(context, '/sellerLogin'))
              : const Offstage(),
          divider(),
          tile(Icons.forum, "Feedback & Suggestions",
              () => launchUrl(Uri.parse(Constants.feedbackUrl))),
          divider(),
          logout
              ? tile(Icons.exit_to_app, "Logout", () {
                  logoutUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                })
              : const Offstage(),
          divider(),
        ],
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
