import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
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
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 8),
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

  enquireOnWhatsapp(ProductModel product) async {
    try {
      String whatsappUrl =
          "https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeQueryComponent('Product Images:${product.imageUris}\n Name: ${product.name},\n Price: ${product.price - product.discount}\n Discount given: ${product.discount}(${((product.discount / product.price) * 100).toInt()}%})')}";

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
