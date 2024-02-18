import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:shimmer/shimmer.dart';

class VariantsView extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel, double) onTap;
  final double initialScrollOffset;
  const VariantsView(
      {super.key,
      required this.product,
      required this.onTap,
      required this.initialScrollOffset});

  @override
  State<VariantsView> createState() => _VariantsViewState();
}

class _VariantsViewState extends State<VariantsView> {
  List<ProductModel> variants = [];
  ScrollController variantsScroller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    variantsScroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    variantsScroller =
        ScrollController(initialScrollOffset: widget.initialScrollOffset);
    return FutureBuilder(
      future: getVariants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else {
            if (variants.isNotEmpty) {
              return SizedBox(
                height: 120,
                // width: 120,
                child: ListView.builder(
                  itemCount: variants.length,
                  controller: variantsScroller,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.onTap(
                            variants[index], variantsScroller.position.pixels);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: CachedNetworkImage(
                              // height: 100,
                              imageUrl: variants[index].imageUris.first,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: variants[index].id ==
                                                  widget.product.id
                                              ? AppThemeShared.primaryColor
                                              : Colors.transparent),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill)),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "₹${variants[index].price - variants[index].discount}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 15),
                          ),
                          Text(
                            "₹${variants[index].price}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return variantsShimmer();
            }
          }
        } else {
          return variantsShimmer();
        }
      },
    );
  }

  getVariants() async {
    if (widget.product.variantGroup != null) {
      variants =
          await ProductServices().getVariants(widget.product.variantGroup!);
    }
    return [];
  }

  variantsShimmer() {
    return SizedBox(
      height: 120,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: List.generate(
              10,
              (index) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          color: Colors.grey,
                          height: 20,
                          width: 50,
                        ),
                        const SizedBox(height: 4),
                        Container(color: Colors.grey, height: 20, width: 50)
                      ],
                    ),
                  ))),
    );
  }
}
