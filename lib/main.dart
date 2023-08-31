import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sfh_app/screens/add_category.dart';

void main() {
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
        ),
        onGenerateRoute: _routing,
        home: AddCategory());
  }

  Route _routing(RouteSettings settings) {
    switch (settings.name) {
      case '/addCategory':
        return PageTransition(
            child: const AddCategory(), type: PageTransitionType.leftToRight);
        
      default:
        return PageTransition(
            child: const AddCategory(), type: PageTransitionType.leftToRight);
        ;
    }
  }
}
