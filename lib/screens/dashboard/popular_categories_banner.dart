import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/screens/category/category_shimmer_card.dart';
import 'package:sfh_app/services/category/category_services.dart';

class PopularCategoriesBanner extends StatefulWidget {
  const PopularCategoriesBanner({super.key});

  @override
  State<PopularCategoriesBanner> createState() => _PopularCategoriesBannerState();
}

class _PopularCategoriesBannerState extends State<PopularCategoriesBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      color: const Color(0xffFCD29F),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Categories",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
                const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Color(0xff0D1B2A),
                    ))
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final allCatgories = ref.watch(allCategoriesProvider);
              return allCatgories.when(
                data: (data) {
                  List<CategoryModel> popular = [];
                  for (var category in data) {
                    if (category.popular != null && category.popular!) {
                      popular.add(category);
                    }
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: popular.length,
                    // scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 200),
                    padding: const EdgeInsets.only(left: 6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, '/displayProductsByCategory',
                            arguments: popular[index]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: popular[index].imageUri!,
                                  height: 130,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  popular[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => SizedBox(
                  height: 170,
                  child: ListView.builder(
                    itemCount: 10, // You can set the number of shimmer items
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const CategoryShimmerCard();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
    
}