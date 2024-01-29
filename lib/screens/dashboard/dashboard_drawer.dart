import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class DashboardDrawer extends ConsumerStatefulWidget {
  const DashboardDrawer({super.key});

  @override
  ConsumerState<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends ConsumerState<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding:
            const EdgeInsets.only(top: kToolbarHeight, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addCategory', arguments: null);
                },
                child: Text("Add Category",
                    style: Theme.of(context).textTheme.titleMedium)),
            Divider(
              thickness: 2,
              color: AppThemeShared.secondaryColor,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/manageCategories',
                      arguments: null);
                },
                child: Text("Manage Category",
                    style: Theme.of(context).textTheme.titleMedium)),
            Divider(
              thickness: 2,
              color: AppThemeShared.secondaryColor,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addProduct');
                },
                child: Text("Add Product",
                    style: Theme.of(context).textTheme.titleMedium)),
            Divider(
              thickness: 2,
              color: AppThemeShared.secondaryColor,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/manageProducts');
                },
                child: Text("Manage Products",
                    style: Theme.of(context).textTheme.titleMedium)),
            Divider(
              thickness: 2,
              color: AppThemeShared.secondaryColor,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addSeller');
                },
                child: Text("Add Seller",
                    style: Theme.of(context).textTheme.titleMedium)),
            Divider(
              thickness: 2,
              color: AppThemeShared.secondaryColor,
            ),
            GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/addSeller');
                  NotificationService().sendToAll();
                },
                child: Text("Send Notification",
                    style: Theme.of(context).textTheme.titleMedium)),
          ],
        ),
      ),
    );
  }
}
