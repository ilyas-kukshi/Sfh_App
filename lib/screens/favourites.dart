import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Favourites", context: context),
      // body: ,
    );
  }
}
