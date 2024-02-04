import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/auth/login.dart';
import 'package:sfh_app/screens/category/add_category.dart';
import 'package:sfh_app/screens/category/manage_categories.dart';
import 'package:sfh_app/screens/dashboard/bottom_nav.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/screens/product/add_products.dart';
import 'package:sfh_app/screens/product/display_products_by_category.dart';
import 'package:sfh_app/screens/product/edit_product.dart';
import 'package:sfh_app/screens/product/manage_products.dart';
import 'package:sfh_app/screens/product/story_view.dart';
import 'package:sfh_app/screens/product/view_images.dart';
import 'package:sfh_app/screens/product/view_product.dart';
import 'package:sfh_app/screens/seller/add_seller.dart';
import 'package:sfh_app/screens/seller/seller_login.dart';
import 'package:sfh_app/screens/seller/seller_register.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/navigation_service.dart';

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  onDidReceiveLocalNotification: (id, title, body, payload) {
    // print("Darwin: $title");
  },
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
);

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data);
  Fluttertoast.showToast(msg: message.data.toString());

  NotificationService().handleNotificationPayload(message, navigatorKey);

  // if (message.data.isNotEmpty) {
  //   switch (message.data["type"]) {
  //     case "category":
  //       {
  //         CategoryModel? category =
  //             await CategoryServices().getById(message.data["categoryId"]);

  //         if (category != null) {
  //           if (navigatorKey.currentState != null) {
  //             navigatorKey.currentState?.pushNamed('/displayProductsByCategory',
  //                 arguments: category);
  //           }
  //           // NavigationService()
  //           //     .navigateTo('/displayProductsByCategory', arguments: category);
  //         }
  //       }
  //       break;
  //     default:
  //   }
  // }
}

// final NavigationService navigationService = NavigationService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  //When a new notification message is received
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Display notifications received when app is in foreground
    NotificationService().displayForegroundNotification(message);
  });
  //when app is in BACKGROUND and opened through notification
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    firebaseMessagingBackgroundHandler(message);
  });
  //when app is TERMINATED and opened through notification
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      firebaseMessagingBackgroundHandler(message);
    }
  });

  runApp(ProviderScope(
      child: MyApp(
          // navigationService: navigationService,
          )));
}

class MyApp extends StatelessWidget {
  // final NavigationService navigationService;
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // print('MyApp - navigatorKey: ${navigationService.navigatorKey}');
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
                titleMedium: TextStyle(
                    color: AppThemeShared.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22))),
        onGenerateRoute: _routing,
        home: const Login());
  }

  Route _routing(RouteSettings settings) {
    switch (settings.name) {
      case '/bottomNav':
        return PageTransition(
            child: const BottomNav(), type: PageTransitionType.leftToRight);
      case '/dashboardMain':
        return PageTransition(
            child: const DashboardMain(), type: PageTransitionType.leftToRight);
      case '/addCategory':
        return PageTransition(
            child: AddCategory(category: settings.arguments as CategoryModel?),
            type: PageTransitionType.leftToRight);
      case '/manageCategories':
        return PageTransition(
            child: const ManageCategories(),
            type: PageTransitionType.leftToRight);
      case '/addProduct':
        return PageTransition(
            child: const AddProducts(), type: PageTransitionType.leftToRight);
      case '/editProduct':
        return PageTransition(
            child: EditProduct(
              product: settings.arguments as ProductModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/viewProduct':
        return PageTransition(
            child: ViewProduct(
              product: settings.arguments as ProductModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/viewStory':
        return PageTransition(
            child: StoryPage(
              data: settings.arguments as Map<String, dynamic>,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case '/viewImages':
        return PageTransition(
            child: ViewImages(
              imageUris: settings.arguments as List<String>,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case '/manageProducts':
        return PageTransition(
            child: const ManageProducts(),
            type: PageTransitionType.leftToRight);
      case '/displayProductsByCategory':
        return PageTransition(
            child: DisplayProductsByCategory(
              category: settings.arguments as CategoryModel,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case '/sellerLogin':
        return PageTransition(
            child: const SellerLogin(), type: PageTransitionType.leftToRight);
      case '/sellerRegister':
        return PageTransition(
            child: const SellerRegister(),
            type: PageTransitionType.leftToRight);
      case '/addSeller':
        return PageTransition(
            child: const AddSeller(), type: PageTransitionType.leftToRight);
      default:
        return PageTransition(
            child: Login(), type: PageTransitionType.leftToRight);
    }
  }
}
