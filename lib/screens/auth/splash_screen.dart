import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      navigateTo();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Utility().catchDeepLinks(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThemeShared.primaryColor,
    );
  }

  Future<void> navigateTo() async {
    String? token = await Utility().getStringSf("token");

    // print(token);
    if (token == null) {
      Navigator.pushNamed(context, '/login');
    } else {
      final user = ref.read(getUserByTokenProvider(token).future);
      user.then((value) {
        if (value != null) {
          Navigator.pushNamed(context, '/bottomNav', arguments: 0);
        }
      });
    }
  }
}
