import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard {
  Widget productCard(ProductModel product, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/viewImages',
              arguments: product.imageUris);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUris.first,
              height: 220,
              width: MediaQuery.of(context).size.width * 0.48,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                // IconButton(
                //   icon: Icon(
                //     Icons.favorite,
                //     color: Colors.grey,
                //   ),
                //   onPressed: () {},
                // )
              ],
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
                  enquireOnWhatsapp(product);
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

  enquireOnWhatsapp(ProductModel product) async {
    try {
      String whatsappUrl =
          "https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeQueryComponent('Product Images:${product.imageUris}\n Name: ${product.name},\n Price: ${product.price - product.discount}\n Discount given: ${product.discount}(${((product.discount / product.price) * 100).toInt()}%})')}";

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
