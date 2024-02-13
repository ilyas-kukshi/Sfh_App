// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/screens/product/variants_view.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/utility.dart';

class ViewProduct extends StatefulWidget {
  ProductModel product;
  ViewProduct({super.key, required this.product});

  @override
  State<ViewProduct> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ViewProduct> {
  double variantScrollPosition = 0;
  double initialScrollOffset = 0;

  List<ProductModel> similarProducts = [];

  @override
  void initState() {
    super.initState();
    getProducts(widget.product.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // bottom: false,
      child: Scaffold(
        appBar: AppThemeShared.appBar(
            title: widget.product.name,
            context: context,
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, '/displayProductsByCategory',
                    arguments: widget.product.category),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    widget.product.category.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          color: AppThemeShared.primaryColor,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  widget.product.name,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 4),
              Carousel(
                height: 350,
                isUrl: true,
                imageUrls: widget.product.imageUris,
                files: const [],
                productId: widget.product.id,
              ),
              widget.product.variantGroup != null
                  ? VariantsView(
                      product: widget.product,
                      initialScrollOffset: initialScrollOffset,
                      onTap: (selectedProduct, scrollOffset) {
                        widget.product = selectedProduct;
                        initialScrollOffset = scrollOffset;
                        setState(() {});
                      },
                    )
                  : const Offstage(),
              const Divider(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${((widget.product.discount / widget.product.price) * 100).toInt()}% OFF",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26, color: Colors.redAccent),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text("₹${widget.product.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontSize: 20,
                                      color: Colors.grey.shade600,
                                      decoration: TextDecoration.lineThrough)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                            "₹${widget.product.price - widget.product.discount}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 32,
                                )),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        widget.product.freeShipping
                            ? const Offstage()
                            : const Icon(Icons.add),
                        Icon(
                          Icons.local_shipping,
                          color: AppThemeShared.primaryColor,
                        ),
                        const SizedBox(width: 6),
                        widget.product.freeShipping
                            ? Text("Free Shipping",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    ))
                            : Text("Shipping Charges",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      fontSize: 14,
                                    )),
                      ],
                    ),
                    widget.product.colors != null &&
                            widget.product.colors!.isNotEmpty
                        ? Row(
                            children: [
                              const Text(
                                "Colors: ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Wrap(
                                children: widget.product.colors!
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 35,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                color:
                                                    Color(int.parse("0xff$e")),
                                                shape: BoxShape.circle),
                                          ),
                                        ))
                                    .toList(),
                              )
                            ],
                          )
                        : const Offstage(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppThemeShared.sharedButton(
                    context: context,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.96,
                    borderColor: AppThemeShared.primaryColor,
                    borderRadius: 12,
                    borderWidth: 2,
                    buttonText: "Enquire",
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppThemeShared.primaryColor),
                    // elevation: 2,
                    color: Colors.transparent,
                    onTap: () {
                      Utility().enquireOnWhatsapp(widget.product);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppThemeShared.sharedButton(
                    context: context,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.48,
                    borderRadius: 12,
                    elevation: 5,
                    // borderWidth: 2,
                    color: const Color(0xffFFA500),
                    buttonText: "Add To Cart",
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                    onTap: () {
                      // ProductCard().enquireOnWhatsapp(widget.product);
                    },
                  ),
                  Center(
                    child: AppThemeShared.sharedButton(
                      context: context,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.48,
                      borderRadius: 12,
                      elevation: 5,
                      // borderWidth: 2,
                      color: const Color(0xffFF6347),
                      buttonText: "Buy Now",
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                      onTap: () {
                        // ProductCard().enquireOnWhatsapp(widget.product);
                      },
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Similar Products",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              similarProducts.isNotEmpty
                  ? GridView.builder(
                      itemCount: similarProducts.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 350,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0),
                      itemBuilder: (context, index) {
                        return ProductCard(product: similarProducts[index]);
                      },
                    )
                  : GridView.builder(
                      itemCount: 20,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 350,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0),
                      itemBuilder: (context, index) {
                        return ProductShimmer().productShimmerVertical(context);
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  getProducts(String categoryId) async {
    similarProducts.clear();
    similarProducts = await ProductServices().getByCategory(categoryId);
    similarProducts.remove(widget.product);
    // print("Products");
    // print(products);
    setState(() {});
  }
}
