import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sfh_app/models/address/address_model.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/auth/login.dart';
import 'package:sfh_app/screens/auth/otp.dart';
import 'package:sfh_app/screens/auth/splash_screen.dart';
import 'package:sfh_app/screens/admin/add_category.dart';
import 'package:sfh_app/screens/admin/manage_categories.dart';
import 'package:sfh_app/screens/admin/manage_tags.dart';
import 'package:sfh_app/screens/dashboard/bottom_nav.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/screens/dashboard/new_arrivals/new_arrivals.dart';
import 'package:sfh_app/screens/order/order_summary.dart';
import 'package:sfh_app/screens/seller/add_products.dart';
import 'package:sfh_app/screens/product/display_products_by_category.dart';
import 'package:sfh_app/screens/product/display_products_by_tags.dart';
import 'package:sfh_app/screens/seller/edit_product.dart';
import 'package:sfh_app/screens/seller/manage_products.dart';
import 'package:sfh_app/screens/product/story_view.dart';
import 'package:sfh_app/screens/product/view_images.dart';
import 'package:sfh_app/screens/product/view_product.dart';
import 'package:sfh_app/screens/admin/add_seller.dart';
import 'package:sfh_app/screens/seller/seller_login.dart';
import 'package:sfh_app/screens/user/address/add_address.dart';
import 'package:sfh_app/screens/user/address/manage_address.dart';
import 'package:sfh_app/screens/user/my_cart.dart';
import 'package:sfh_app/screens/user/seller_register.dart';
import 'package:sfh_app/screens/user/wishlist.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  onDidReceiveLocalNotification: (id, title, body, payload) {
    if (payload != null) {
      firebaseMessagingBackgroundHandler(
          RemoteMessage(data: jsonDecode(payload)));
    }
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
  // Fluttertoast.showToast(msg: message.data.toString());

  NotificationService.handleNotificationPayload(message, navigatorKey);
}

// final NavigationService navigationService = NavigationService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final globalProviderContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  NotificationService().catchNotification();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      if (details.payload != null) {
        RemoteMessage message =
            RemoteMessage(data: jsonDecode(details.payload!));
        firebaseMessagingBackgroundHandler(message);
      }
    },
  );

  runApp(ProviderScope(parent: globalProviderContainer, child: const MyApp()));
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  // final NavigationService navigationService;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('MyApp - navigatorKey: ${navigationService.navigatorKey}');
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
            progressIndicatorTheme: ProgressIndicatorThemeData(
                color: AppThemeShared.primaryColor,
                circularTrackColor: Colors.black.withOpacity(0.4)),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              titleLarge: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      color: Color(0xff0D1B2A), fontWeight: FontWeight.w500)),
              titleMedium: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                color: Color(0xff0D1B2A),
                fontWeight: FontWeight.w600,
              )),
              //use for buttons
              labelLarge: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                color: Color(0xff0D1B2A),
                fontWeight: FontWeight.w600,
              )),
              //use for hint and label texts of textformfields/dropdowns etc
              labelMedium: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontFamily: 'Roboto', color: Color(0xff0D1B2A))),
            )),
        onGenerateRoute: _routing,
        home: const SplashScreen());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {}
  }

  Route _routing(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return PageTransition(
            child: const Login(), type: PageTransitionType.leftToRight);
      case '/otp':
        return PageTransition(
            child: Otp(
              authDetails: settings.arguments as Map<String, String>,
            ),
            type: PageTransitionType.leftToRight);
      case '/bottomNav':
        return PageTransition(
            child: BottomNav(
              screen: settings.arguments as int,
            ),
            type: PageTransitionType.leftToRight);
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
      case '/manageTags':
        return PageTransition(
            child: ManageTags(
              category: settings.arguments as CategoryModel,
            ),
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
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/viewStory':
        return PageTransition(
            child: StoryPage(
              data: settings.arguments as Map<String, dynamic>,
            ),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 500),
            alignment: Alignment.center);
      case '/viewImages':
        return PageTransition(
            child: ViewImages(
              imageUris: settings.arguments as List<String>,
            ),
            type: PageTransitionType.scale,
            alignment: Alignment.center);
      case '/wishlist':
        return PageTransition(
            child: Wishlist(
              phoneNumber: settings.arguments as String,
              // imageUris: settings.arguments as List<String>,
            ),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/mycart':
        return PageTransition(
            child: const MyCart(),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/manageAddress':
        return PageTransition(
            child: ManageAddress(
              selectAddress: settings.arguments as bool,
            ),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/addAddress':
        return PageTransition(
            child: const AddAddress(
                // onAddressAdded: settings.arguments as AddAddressCallback,
                ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 400),
            alignment: Alignment.center);
      case '/orderSummary':
        return PageTransition(
            child: OrderSummary(
              address: settings.arguments as AddressModel,
            ),
            type: PageTransitionType.leftToRight);
      case '/manageProducts':
        return PageTransition(
            child: ManageProducts(
              filters: settings.arguments as Map<String, String>,
            ),
            type: PageTransitionType.leftToRight);
      case '/newArrivals':
        return PageTransition(
            child: const NewArrivals(),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/displayProductsByCategory':
        return PageTransition(
            child: DisplayProductsByCategory(
              category: settings.arguments as CategoryModel,
            ),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
            alignment: Alignment.center);
      case '/displayProductsByTags':
        return PageTransition(
            child: DisplayProductsByTags(
              tags: settings.arguments as List<TagModel>,
            ),
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 700),
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
            child: const Login(), type: PageTransitionType.leftToRight);
    }
  }
}
