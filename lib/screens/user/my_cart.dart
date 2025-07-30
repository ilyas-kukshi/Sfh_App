import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/order/order_service.dart';
import 'package:sfh_app/services/user_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String? token;
  int price = 0;
  int discount = 0;
  List<ProductModel> products = [];
  Future<void> getToken() async {
    token = await Utility().getStringSf("token");
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  String getTotalPrice(List<ProductModel> products) {
    price = 0;
    for (var product in products) {
      if (!product.available) {
        continue;
      }
      price += product.price;
    }
    return price.toString();
  }

  int getDiscount(List<ProductModel> products) {
    discount = 0;
    for (var product in products) {
      if (!product.available) {
        continue;
      }
      discount += product.discount;
    }
    return discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 214, 208, 208),
      appBar: AppThemeShared.appBar(
          title: "My Cart", context: context, backButton: false),
      body: FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (token != null) {
              return Consumer(
                builder: (context, ref, child) {
                  final userProvider =
                      ref.watch(getUserByTokenProvider(token!));
                  return userProvider.when(
                    data: (user) {
                      if (user!.mycart == null || user.mycart!.isEmpty) {
                        return Center(
                            child: Text(
                          "Add some products in cart",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(),
                        ));
                      } else {
                        products = user.mycart!;
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "₹${getTotalPrice(products)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontSize: 18,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.grey),
                                              ),
                                              Text(
                                                "₹${price - getDiscount(products)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      AppThemeShared.sharedButton(
                                        percent: true,
                                        widthPercent: 0.4,
                                        height: 45,
                                        context: context,
                                        buttonText: "Proceed to buy",
                                        onTap: () {
                                          ref
                                              .read(orderListNotifierProvider)
                                              .clear();
                                          for (var product in user.mycart!) {
                                            if (!product.available) {
                                              continue;
                                            }
                                            ref
                                                .read(orderListNotifierProvider)
                                                .add(product);
                                          }
                                          Navigator.pushNamed(
                                              context, '/manageAddress',
                                              arguments: true);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SliverList.builder(
                              itemCount: user.mycart!.length,
                              itemBuilder: (context, index) {
                                return productCard(user.mycart![index], ref);
                              },
                            ),
                          ],
                        );
                      }
                    },
                    error: (error, stackTrace) => const Offstage(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  "Login for best experience",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar:
    );
  }

  Widget productCard(ProductModel product, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/viewProduct', arguments: product),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 130,
                width: MediaQuery.of(context).size.width * 0.25,
                imageUrl: product.imageUris.first,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 22),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${product.price}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                        ),
                        const SizedBox(width: 12),
                        Text("₹${product.price - product.discount}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 20)),
                      ],
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      "₹${((product.discount / product.price) * 100).toInt()}% OFF",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.orange),
                    ),
                    product.available
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppThemeShared.sharedButton(
                                context: context,
                                color: const Color(0xffFFA500),
                                height: 40,
                                percent: true,
                                widthPercent: 0.28,
                                buttonText: "Buy now",
                                onTap: () {
                                  ref.read(orderListNotifierProvider).clear();
                                  ref
                                      .read(orderListNotifierProvider)
                                      .add(product);
                                  Navigator.pushNamed(context, '/manageAddress',
                                      arguments: true);
                                },
                              ),
                              const SizedBox(width: 12),
                              AppThemeShared.sharedButton(
                                context: context,
                                color: const Color(0xffFF6347),
                                height: 40,
                                percent: true,
                                widthPercent: 0.28,
                                buttonText: "Remove",
                                onTap: () async {
                                  bool updated = await UserService()
                                      .updateCart(product.id!, token!);
                                  if (updated) {
                                    ref.refresh(getUserByTokenProvider(token!));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Cart not updated");
                                  }
                                },
                              )
                            ],
                          )
                        : Text(
                            "Out of stock",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.red),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
