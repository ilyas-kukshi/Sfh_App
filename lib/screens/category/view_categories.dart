import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:shimmer/shimmer.dart';

class ViewCategories extends ConsumerStatefulWidget {
  const ViewCategories({super.key});

  @override
  ConsumerState<ViewCategories> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends ConsumerState<ViewCategories> {
  List<CategoryModel> categories = [];

  @override
  Widget build(BuildContext context) {
    var allCategories = ref.watch(allCategoriesProvider);
    return Scaffold(
        appBar: AppThemeShared.appBar(
            title: "Categories", context: context, backButton: false),
        body: allCategories.when(
          data: (data) => GridView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) => categoryCard(data[index]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 200),
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => GridView.builder(
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) => categoryShimmerCard(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 200),
          ),
        ));
  }

  Widget categoryShimmerCard() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 130,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              Container(
                height: 20,
                color: Colors.grey,
              )
            ],
          ),
        ));
  }

  Widget categoryCard(CategoryModel category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/displayProductsByCategory',
            arguments: category),
        child: Card(
          child: Column(
            children: [
              category.imageUri != null
                  ? CachedNetworkImage(
                      height: 130,
                      width: double.infinity,
                      imageUrl: category.imageUri!,
                      fit: BoxFit.fill,
                      // imageBuilder: (context, imageProvider) => Container(
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           image: imageProvider, fit: BoxFit.cover)),
                      // ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppThemeShared.primaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const Offstage(),
              const SizedBox(height: 10),
              Center(child: Text(category.name))
            ],
          ),
        ),
      ),
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    return await CategoryServices().getAll();
    // print(categories);
  }
}
