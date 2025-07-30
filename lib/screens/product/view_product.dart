// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/product/variants_view.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/user_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:share_plus/share_plus.dart';

class ViewProduct extends ConsumerStatefulWidget {
  ProductModel product;
  ViewProduct({super.key, required this.product});

  @override
  ConsumerState<ViewProduct> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ViewProduct> {
  double variantScrollPosition = 0;
  double initialScrollOffset = 0;

  bool updatingWishlist = false;

  List<ProductModel> similarProducts = [];

  String? token;

  @override
  void initState() {
    super.initState();
  }

  Future<String?> getToken() async {
    token = await Utility().getStringSf("token");
    return token;
  }

  Future<bool> updateWishlist(String productId, String userId) async {
    return await UserService().updateWishlist(productId, userId);
  }

  Future<bool> updateCart(String productId) async {
    return await UserService().updateCart(productId, token!);
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
              .copyWith(color: Colors.white),
          actions: [
            // GestureDetector(
            //   onTap: () =>
            //       Navigator.pushNamed(context, '/bottomNav', arguments: 2),
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Icon(
            //       Icons.shopping_bag,
            //       color: Colors.white,
            //     ),
            //   ),
            // )
          ]),
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
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.product.category.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: AppThemeShared.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppThemeShared.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.product.name,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 16, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 4),
            Stack(
              children: [
                Carousel(
                  height: 330,
                  isUrl: true,
                  imageUrls: widget.product.imageUris,
                  files: const [],
                  productId: widget.product.id,
                ),
                GestureDetector(
                  onTap: () {
                    Uri deeplink = Utility().buildDeepLink(
                        '/product', {"productId": widget.product.id!});
                    SharePlus.instance.share(ShareParams(text: "$deeplink"));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        favouriteIcon(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.share)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
                      Text("₹${widget.product.price - widget.product.discount}",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                                              color: Color(int.parse("0xff$e")),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           fixedSize: Size(
            //             MediaQuery.of(context).size.width * 0.96,
            //             50,
            //           ),
            //           backgroundColor: Colors.white,
            //           elevation: 0,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           side: BorderSide(
            //               color: AppThemeShared.primaryColor, width: 2)),
            //       onPressed: () =>
            //           Utility().enquireOnWhatsapp(widget.product, ''),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Enquire",
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .labelLarge!
            //                 .copyWith(
            //                     color: AppThemeShared.primaryColor,
            //                     fontSize: 16,
            //                     letterSpacing: 1.1),
            //           ),
            //           const SizedBox(width: 8),
            //           CachedNetworkImage(
            //               height: 30,
            //               width: 25,
            //               imageUrl:
            //                   "https://e7.pngegg.com/pngimages/551/579/png-clipart-whats-app-logo-whatsapp-logo-whatsapp-cdr-leaf-thumbnail.png")
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),

            // const SizedBox(height: 4),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     addToCartButton(),
            // Center(
            //   child: AppThemeShared.sharedButton(
            //     context: context,
            //     height: 50,
            //     width: MediaQuery.of(context).size.width * 0.48,
            //     borderRadius: 12,
            //     elevation: 5,
            //     // borderWidth: 2,
            //     color: const Color(0xffFF6347),
            //     buttonText: "Buy Now",
            //     textStyle: Theme.of(context)
            //         .textTheme
            //         .labelLarge!
            //         .copyWith(color: Colors.white),
            //     onTap: () {
            //       if (token == null) {
            //         Utility().enquireOnWhatsapp(widget.product,
            //             "I would like to buy this product");
            //       } else {
            //         ref.read(orderListNotifierProvider).clear();
            //         ref
            //             .read(orderListNotifierProvider)
            //             .add(widget.product);
            //         Navigator.pushNamed(context, '/manageAddress',
            //             arguments: true);
            //       }
            //     },
            //   ),
            // ),
            //   ],
            // ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () => Utility().enquireOnWhatsapp(widget.product, ''),
        label: Column(
          children: [
            Image.asset(
              "assets/images/whatsapp-logo.png",
              width: 60,
              height: 50,
            ),
            // CachedNetworkImage(
            //     // height: 50,
            //     width: 30,
            //     imageUrl:
            //         "https://e7.pngegg.com/pngimages/551/579/png-clipart-whats-app-logo-whatsapp-logo-whatsapp-cdr-leaf-thumbnail.png"),
            // Text(
            //   "Enquire",
            //   style: Theme.of(context).textTheme.labelLarge!.copyWith(
            //       color: AppThemeShared.primaryColor,
            //       fontWeight: FontWeight.bold),
            // )
          ],
        ),
      ),
    ));
  }

  final platform = const MethodChannel('upi_payment/init');

  // Future<void> initiateUpiPayment(String upiLink) async {
  //   try {
  //     final response =
  //         await platform.invokeMethod('init', {'upiLink': upiLink});
  //   } on PlatformException catch (e) {
  //     print("Error: ${e.message}");
  //   }
  // }

  Widget favouriteIcon() {
    return FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          return Consumer(
            builder: (context, ref, child) {
              if (token != null) {
                final user = ref.watch(getUserByTokenProvider(token!));
                return user.when(
                  data: (data) {
                    if (data == null) {
                      return const Offstage();
                    } else if (data.wishlist == null ||
                        !data.wishlist!.contains(widget.product)) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            updatingWishlist = true;
                          });

                          bool updated = await updateWishlist(
                              widget.product.id!, data.id!);
                          if (updated) {
                            final update = ref
                                .refresh(getUserByTokenProvider(token!).future);
                            update.then((value) => {updatingWishlist = false});
                          } else {
                            Fluttertoast.showToast(msg: "Wishlist not updated");
                          }
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: updatingWishlist
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.favorite_border_outlined)),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            updatingWishlist = true;
                          });
                          bool updated = await updateWishlist(
                              widget.product.id!, data.id!);
                          if (updated) {
                            final update = ref
                                .refresh(getUserByTokenProvider(token!).future);
                            update.then((value) => setState(() {
                                  updatingWishlist = false;
                                }));
                          } else {
                            Fluttertoast.showToast(msg: "Wishlist not updated");
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: updatingWishlist
                              ? const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.grey,
                                  ),
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                        ),
                      );
                    }
                  },
                  error: (error, stackTrace) => const Offstage(),
                  loading: () => const Offstage(),
                );
              } else {
                return const Offstage();
              }
            },
          );
        });
  }

  Widget addToCartButton() {
    return FutureBuilder(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(getUserByTokenProvider(token ?? ''));
              return user.when(
                data: (user) {
                  return AppThemeShared.sharedButton(
                    context: context,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.96,
                    borderRadius: 12,
                    elevation: 5,
                    // borderWidth: 2,
                    color: const Color(0xffFFA500),
                    buttonText: user != null
                        ? user.mycart == null ||
                                !user.mycart!.contains(widget.product)
                            ? "Add to cart"
                            : "Remove from cart"
                        : "Add To Cart",
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                    onTap: () async {
                      if (user != null) {
                        bool updated = await updateCart(widget.product.id!);
                        if (updated) {
                          final update = ref
                              .refresh(getUserByTokenProvider(token!).future);
                          update.then((value) => setState(() {}));
                        } else {
                          Fluttertoast.showToast(msg: "Cart not updated");
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Login for best experience");
                        Navigator.pushNamed(context, '/bottomNav',
                            arguments: 3);
                      }

                      // ProductCard().enquireOnWhatsapp(widget.product);
                    },
                  );
                },
                error: (error, stackTrace) => const Offstage(),
                loading: () => const Offstage(),
              );
            },
          );
        } else {
          return const Offstage();
        }
      },
    );
  }
}
