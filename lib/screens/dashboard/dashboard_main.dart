import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/screens/dashboard/bottom_nav.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/services/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();

  List<CategoryModel> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: DashboardDrawer(),
      appBar: AppThemeShared.appBar(
          title: "",
          context: context,
          backButton: false,
          leading: GestureDetector(
            onTap: () {
              globalKey.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    categories = snapshot.data as List<CategoryModel>;
                    return SizedBox(
                      height: 175,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return categoryCard(categories[index]);
                        },
                      ),
                    );
                  } else {
                    return const Text("No data");
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Latest",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  Widget categoryCard(CategoryModel category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            category.imageUri != null
                ? CachedNetworkImage(
                    height: 120,
                    width: 120,
                    imageUrl: category.imageUri!,
                    fit: BoxFit.fill,
                    // imageBuilder: (context, imageProvider) => Container(
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           image: imageProvider, fit: BoxFit.cover)),
                    // ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : const Offstage(),
            const SizedBox(height: 10),
            Center(child: Text(category.name))
          ],
        ),
      ),
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    return await CategoryServices().getAll();
    // print(categories);
  }
}
