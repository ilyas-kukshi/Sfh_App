// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';
import 'package:sfh_app/shared/product_card.dart';

class ViewProduct extends StatefulWidget {
  ProductModel product;
  ViewProduct({super.key, required this.product});

  @override
  State<ViewProduct> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ViewProduct> {
  List<ProductModel> similarProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts(widget.product.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // bottom: false,
      child: Scaffold(
        appBar:
            AppThemeShared.appBar(title: widget.product.name, context: context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Carousel(
                height: 400,
                isUrl: true,
                imageUrls: widget.product.imageUris,
                files: const [],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${widget.product.price}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "₹${widget.product.price - widget.product.discount}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.red.withOpacity(0.85),
                                Colors.orange
                              ],
                                  stops: const [
                                1,
                                1
                              ],
                                  tileMode: TileMode.clamp,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight)),
                          child: Text(
                            "₹${((widget.product.discount / widget.product.price) * 100).toInt()}% OFF",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
                            ? const Text("Free Shipping")
                            : const Text("Shipping Charges"),
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
              // const SizedBox(height: 10),
              Row(
                children: [
                  AppThemeShared.sharedButton(
                    context: context,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    buttonText: "Enquire",
                    color: AppThemeShared.secondaryColor,
                    onTap: () {
                      ProductCard().enquireOnWhatsapp(widget.product);
                    },
                  ),
                  AppThemeShared.sharedButton(
                    context: context,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    buttonText: "Add To Cart",
                    onTap: () {
                      ProductCard().enquireOnWhatsapp(widget.product);
                    },
                  ),
                ],
              ),
              // const SizedBox(height: 4),
              AppThemeShared.sharedButton(
                context: context,
                height: 50,
                width: MediaQuery.of(context).size.width,
                buttonText: "Buy Now",
                borderColor: AppThemeShared.primaryColor,
                onTap: () {
                  ProductCard().enquireOnWhatsapp(widget.product);
                },
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
                        return ProductCard()
                            .productCard(similarProducts[index], context);
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
                        return ProductCard().productShimmerCard(context);
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
