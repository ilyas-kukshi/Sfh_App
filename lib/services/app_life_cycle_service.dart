import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/main.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/shared/utility.dart';

class AppLifecycleService with WidgetsBindingObserver {
  // Singleton instance
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  String? phoneNumber;
  String userId = '';
  factory AppLifecycleService() {
    return _instance;
  }

  AppLifecycleService._internal();

  void startObserving() {
    WidgetsBinding.instance.addObserver(this);
  }

  void stopObserving() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      performBackgroundAction();
    } else if (state == AppLifecycleState.resumed) {}
  }

  void performBackgroundAction() async {
    await getPhoneNumber();
    // print(phoneNumber);
    if (phoneNumber != null) {
      final user =
          globalProviderContainer.read(getUserByTokenProvider(phoneNumber!));
      user.whenData((value) {
        userId = value!.id!;
      });
    }
    final views = globalProviderContainer.read(viewsCounterNotifierProvider);
    if (views.isNotEmpty) {
      bool updated = await ProductServices().updateViews(views, userId);
      if (updated) {
        globalProviderContainer.read(viewsCounterNotifierProvider).clear();
      }
    }

    // print(views);
  }

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();
    // print(phoneNumber);
  }
}
