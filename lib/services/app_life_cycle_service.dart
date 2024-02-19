import 'package:flutter/widgets.dart';

class AppLifecycleService with WidgetsBindingObserver {
  // Singleton instance
  static final AppLifecycleService _instance = AppLifecycleService._internal();

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
      // App is in the background
      print('App is in the background');
      // Perform your background action here
      performBackgroundAction();
    } else if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      print('App is in the foreground');
    }
  }

  void performBackgroundAction() {
    
  }
}
