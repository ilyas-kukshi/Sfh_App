import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/user_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String? token;
  bool updatingWishlist = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/viewProduct',
              arguments: widget.product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              width: MediaQuery.of(context).size.width * 0.46,
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://img.freepik.com/free-photo/clear-empty-photographer-studio-background-abstract-background-texture-beauty-dark-light-clear-blue-cold-gray-snowy-white-gradient-flat-wall-floor-empty-spacious-room-winter-interior_1258-53070.jpg?size=626&ext=jpg&ga=GA1.1.834066242.1705652128&semt=ais"),
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageUris.first,
                      height: 170,
                      width: MediaQuery.of(context).size.width * 0.35,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.topRight, child: favouriteIcon()),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.48,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      widget.product.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     Uri deeplink = Utility().buildDeepLink(
                  //         '/widget.product', {"widget.productId": widget.product.id!});
                  //     Share.share("$deeplink");
                  //   },
                  //   child: const Padding(
                  //     padding: EdgeInsets.only(left: 8.0),
                  //     child: Icon(
                  //       Icons.share,
                  //       size: 23,
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "₹${widget.product.price}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(width: 4),
                Text("₹${widget.product.price - widget.product.discount}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 20)),
                const SizedBox(width: 4),
                Text(
                  "₹${((widget.product.discount / widget.product.price) * 100).toInt()}% OFF",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.orange),
                ),
              ],
            ),
            // const SizedBox(height: 8),
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
                    ? Text(
                        "Free Shipping",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontSize: 14),
                      )
                    : Text("Shipping Charges",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontSize: 14)),
              ],
            ),
            // : const Offstage(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.48, 40),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                onPressed: () {
                  Utility().enquireOnWhatsapp(widget.product);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enquire",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppThemeShared.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    CachedNetworkImage(
                        height: 30,
                        width: 25,
                        imageUrl:
                            "https://e7.pngegg.com/pngimages/551/579/png-clipart-whats-app-logo-whatsapp-logo-whatsapp-cdr-leaf-thumbnail.png")
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<String?> getToken() async {
    token = await Utility().getStringSf("token");
    return token;
  }

  Widget favouriteIcon() {
    return FutureBuilder<String?>(
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
                            // ignore: unused_result
                            final update = ref
                                .refresh(getUserByTokenProvider(token!).future);

                            update.then((value) => setState(() {
                                  updatingWishlist = false;
                                }));
                          } else {
                            Fluttertoast.showToast(msg: "Wishlist not updated");
                          }
                        },
                        child: updatingWishlist
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator())
                            : const Icon(Icons.favorite_border_outlined),
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
                            // ignore: unused_result
                            final update = ref
                                .refresh(getUserByTokenProvider(token!).future);
                            update.then((value) => setState(() {
                                  updatingWishlist = false;
                                }));
                          } else {
                            Fluttertoast.showToast(msg: "Wishlist not updated");
                          }
                        },
                        child: updatingWishlist
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.transparent,
                                ))
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                      );
                    }
                  },
                  error: (error, stackTrace) => const Offstage(),
                  loading: () => const Offstage(),
                );
              } else {
                return const Icon(Icons.favorite_border_outlined);
              }
            },
          );
        });
  }

  Future<bool> updateWishlist(String productId, String userId) async {
    return await UserService().updateWishlist(productId, userId);
  }
}


// class ProductCard {
//   Widget productCard(ProductModel product, BuildContext context) {
    // return 
//   }



  
// }
