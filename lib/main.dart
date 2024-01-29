import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
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
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  onDidReceiveLocalNotification: (id, title, body, payload) {
    // print("Darwin: $title");
  },
);
final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsDarwin,
);

//when notification is tapped while app is in background
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();

  // AdmobService().createInterstitialAd();
  // FirebaseMessaging.onBackgroundMessage((message) => notificationTa)

  //When a new notification message is received
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle foreground notifications
    NotificationService().displayForegroundNotification(message);
  });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
                titleMedium: TextStyle(
                    color: AppThemeShared.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22))),
        onGenerateRoute: _routing,
        home: const BottomNav());
  }

  Route _routing(RouteSettings settings) {
    switch (settings.name) {
      case '/bottomNav':
        return PageTransition(
            child: const BottomNav(), type: PageTransitionType.leftToRight);
      case '/dashboardMain':
        return PageTransition(
            child: DashboardMain(), type: PageTransitionType.leftToRight);
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
            child: AddCategory(
              category: settings.arguments as CategoryModel,
            ),
            type: PageTransitionType.leftToRight);
    }
  }
}
