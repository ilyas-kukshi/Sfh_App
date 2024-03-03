import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/screens/category/category_shimmer_card.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class DiverseFindsBanner extends StatefulWidget {
  const DiverseFindsBanner({super.key});

  @override
  State<DiverseFindsBanner> createState() => _DiverseFindsBannerState();
}

class _DiverseFindsBannerState extends State<DiverseFindsBanner> {
  List<CategoryModel> categories = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Diverse Finds",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: const Color(0xff0D1B2A),
                  fontSize: 22,
                  fontWeight: FontWeight.w500)),
        ),
        Consumer(
          builder: (context, ref, child) {
            final allCatgories = ref.watch(allCategoriesProvider);
            return allCatgories.when(
              data: (data) => SizedBox(
                height: 125,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: allCatgories.value!.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 6),
                  itemBuilder: (context, index) {
                    categories = allCatgories.value!;
                    return categoryCard(allCatgories.value![index], index);
                  },
                ),
              ),
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
    );
  }

  Widget categoryCard(CategoryModel category, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/viewStory',
            arguments: {"categories": categories, "currCategoryIndex": index});
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            category.imageUri != null
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.green, width: 2.5)),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green.withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                        // top: 10,
                        // bottom: 40,
                        child: CachedNetworkImage(
                          height: 80,
                          width: 80,
                          imageUrl: category.imageUri!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Offstage(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  )
                : const Offstage(),
            const SizedBox(height: 4),
            Center(
                child: Text(
              category.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppThemeShared.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))
          ],
        ),
      ),
    );
  }
}
