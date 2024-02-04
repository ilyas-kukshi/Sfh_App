import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard {
  Widget productCard(ProductModel product, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/viewProduct', arguments: product);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
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
                  CachedNetworkImage(
                    imageUrl: product.imageUris.first,
                    height: 220,
                    width: MediaQuery.of(context).size.width * 0.48,
                    fit: BoxFit.fill,
                  ),
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Uri deeplink = Utility().buildDeepLink(
                          '/product', {"productId": product.id!});
                      Share.share("$deeplink");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.share,
                        size: 23,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(width: 4),
                Text(
                  "₹${product.price - product.discount}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                Text(
                  "₹${((product.discount / product.price) * 100).toInt()}% OFF",
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
                    ? const Text("Free Shipping")
                    : const Text("Shipping Charges"),
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
                  Utility().enquireOnWhatsapp(product);
                },
                child: Text(
                  "Enquire",
                  style: TextStyle(color: AppThemeShared.primaryColor),
                ))
          ],
        ),
      ),
    );
  }

  Widget productShimmerCard(BuildContext context) {
    // await Future.delayed(Duration(minutes: 5));
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width * 0.48,
              color: Colors.grey,
            ),
            const SizedBox(height: 2),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.48,
              color: Colors.grey,
            ),
            const SizedBox(height: 2),
            // Container(
            //   height: 20,
            //   width: MediaQuery.of(context).size.width * 0.48,
            //   color: Colors.grey,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.14,
                  color: Colors.grey,
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.14,
                  color: Colors.grey,
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.14,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.48,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.48,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  imageViewed(ProductModel product) async {}
}
