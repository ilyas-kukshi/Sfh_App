import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/user_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';

class Wishlist extends ConsumerStatefulWidget {
  final String phoneNumber;
  const Wishlist({super.key, required this.phoneNumber});

  @override
  ConsumerState<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<Wishlist> {
  String? token;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    token = await Utility().getStringSf("token");
    // print(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Wishlist", context: context),
      body: FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = ref.watch(getUserByTokenProvider(token!));
            return user.when(
              data: (user) {
                if (user != null) {
                  return user.wishlist != null || user.wishlist!.isNotEmpty
                      ? GridView(
                          padding: const EdgeInsets.all(4),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 300, crossAxisCount: 2),
                          children: user.wishlist!
                              .map((product) =>
                                  wishlistProductCard(product, user))
                              .toList(),
                        )
                      : const Center(
                          child: Text("You haven't added any products yet"));
                } else {
                  return const Text("Some Error");
                }
              },
              error: (error, stackTrace) => const Text("Some Error"),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget wishlistProductCard(ProductModel product, UserModel user) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/viewProduct', arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              width: MediaQuery.of(context).size.width * 0.48,
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
                      imageUrl: product.imageUris.first,
                      height: 170,
                      width: MediaQuery.of(context).size.width * 0.35,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                              onTap: () => remove(product, user),
                              child: const Icon(Icons.close)),
                        )),
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
                      product.name,
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
                  "₹${product.price}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(width: 4),
                Text("₹${product.price - product.discount}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(width: 4),
                Text(
                  "₹${((product.discount / product.price) * 100).toInt()}% OFF",
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
                product.freeShipping ? const Offstage() : const Icon(Icons.add),
                Icon(
                  Icons.local_shipping,
                  color: AppThemeShared.primaryColor,
                ),
                const SizedBox(width: 6),
                product.freeShipping
                    ? Text(
                        "Free Shipping",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    : Text("Shipping Charges",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14)),
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
                  // Utility().enquireOnWhatsapp(widget.product);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: AppThemeShared.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Add to cart",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppThemeShared.primaryColor),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<bool> updateWishlist(String productId, String userId) async {
    return await UserService().updateWishlist(productId, userId);
  }

  remove(ProductModel product, UserModel user) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      context: context,
      builder: (context) => Consumer(builder: (context, ref, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            ListTile(
              leading: CachedNetworkImage(
                imageUrl: product.imageUris.first,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
              title: Text(
                product.name,
              ),
            ),
            const Divider(thickness: 1.5),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              title: const Text("Delete"),
              onTap: () async {
                bool updated = await updateWishlist(product.id!, user.id!);
                if (updated) {
                  // ignore: unused_result
                  ref.refresh(getUserByTokenProvider(widget.phoneNumber));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Wishlist not updated");
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
