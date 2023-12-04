import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/screens/category/add_category.dart';
import 'package:sfh_app/screens/category/manage_categories.dart';
import 'package:sfh_app/screens/dashboard/dashboard_main.dart';
import 'package:sfh_app/screens/product/add_products.dart';
import 'package:sfh_app/screens/product/display_products_by_category.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: const DashboardMain());
  }

  Route _routing(RouteSettings settings) {
    switch (settings.name) {
      case '/addCategory':
        return PageTransition(
            child: AddCategory(category: settings.arguments as CategoryModel?),
            type: PageTransitionType.leftToRight);
      case '/manageCategories':
        return PageTransition(
            child: const ManageCategories(),
            type: PageTransitionType.leftToRight);
      case '/addProducts':
        return PageTransition(
            child: const AddProducts(), type: PageTransitionType.leftToRight);
      case '/displayProductsByCategory':
        return PageTransition(
            child: DisplayProductsByCategory(
              category: settings.arguments as CategoryModel,
            ),
            type: PageTransitionType.leftToRight);
      default:
        return PageTransition(
            child: AddCategory(
              category: settings.arguments as CategoryModel,
            ),
            type: PageTransitionType.leftToRight);
    }
  }
}
