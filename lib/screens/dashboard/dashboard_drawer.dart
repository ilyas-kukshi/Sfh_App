import 'package:flutter/material.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addCategory', arguments: null);
                },
                child: Text("Add Category",
                    style: Theme.of(context).textTheme.titleMedium)),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/manageCategories',
                      arguments: null);
                },
                child: Text("Manage Category",
                    style: Theme.of(context).textTheme.titleMedium)),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addProduct');
                },
                child: Text("Add Product",
                    style: Theme.of(context).textTheme.titleMedium)),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/manageProducts');
                },
                child: Text("Manage Products",
                    style: Theme.of(context).textTheme.titleMedium)),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/addSeller');
                },
                child: Text("Add Seller",
                    style: Theme.of(context).textTheme.titleMedium)),
          ],
        ),
      ),
    );
  }
}
