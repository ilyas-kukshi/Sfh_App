import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({super.key});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Address", context: context),
      body: Column(
        children: [],
      ),
    );
  }
}
