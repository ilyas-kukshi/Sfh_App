import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  String? phoneNumber;
  UserModel? userProfile;

  @override
  void initState() {
    super.initState();
    getPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Settings", context: context, backButton: false),
      body: FutureBuilder(
          future: getPhoneNumber(),
          builder: (context, snapshot) {
            if (phoneNumber != null) {
              final user = ref.watch(getUserByNumberProvider(phoneNumber!));
              return user.when(
                data: (data) {
                  if (data != null) {
                    userProfile = data;
                    return functions(data.role == Constants.user, true);
                  } else {
                    return const Text(
                        "Could not find a user on a given credentials, Please Login again.");
                  }
                },
                error: (error, stackTrace) => const Offstage(),
                loading: () => const CircularProgressIndicator(),
              );
            } else {
              return functions(true, false);
            }
          }),
    );
  }

  Widget functions(bool sellerLogin, wishlist) {
    return SingleChildScrollView(
      child: Column(
        children: [
          sellerLogin
              ? tile(Icons.person, "Switch to Seller Account",
                  () => Navigator.pushNamed(context, '/sellerLogin'))
              : const Offstage(),
          divider(),
          tile(Icons.forum, "Feedback & Suggestions",
              () => launchUrl(Uri.parse(Constants.feedbackUrl))),
          divider(),
          wishlist
              ? tile(
                  Icons.favorite_outline_outlined,
                  "Wishlist",
                  () => Navigator.pushNamed(context, '/wishlist',
                      arguments: phoneNumber))
              : const Offstage(),
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

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();
  }
}
