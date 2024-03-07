import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';

class ManageProductCard extends StatefulWidget {
  final ProductModel product;
  final bool available;
  bool selected;
  // final List<String>
  // bool selected;
  final Function(bool, ProductModel) availability;
  final Function(bool, ProductModel) selection;
  ManageProductCard(
      {super.key,
      required this.product,
      required this.available,
      required this.selected,
      required this.availability,
      required this.selection});

  @override
  State<ManageProductCard> createState() => _ManageProductCardState();
}

class _ManageProductCardState extends State<ManageProductCard> {
  // bool selected = false;
  late bool available;

  @override
  void initState() {
    super.initState();
    available = widget.available;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.imageUris.first,
                height: 220,
                width: MediaQuery.of(context).size.width * 0.48,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.48,
                child: Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "₹${widget.product.price}",
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "₹${widget.product.price - widget.product.discount}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "₹${((widget.product.discount / widget.product.price) * 100).toInt()}% OFF",
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Available:"),
                  const SizedBox(width: 8),
                  Switch(
                    activeColor: AppThemeShared.primaryColor,
                    value: available,
                    onChanged: (value) {
                      available = value;
                      // widget.products[index] = widget.product.copyWith(available: value);
                      updateProduct(widget.product.copyWith(available: value));
                      widget.availability(value, widget.product);
                      setState(() {});
                    },
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.48, 40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProduct',
                        arguments: widget.product);
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: AppThemeShared.primaryColor),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              // padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Checkbox(
                value: widget.selected,
                side: BorderSide(width: 3, color: AppThemeShared.primaryColor),
                activeColor: AppThemeShared.primaryColor,
                onChanged: (value) {
                  setState(() {
                    widget.selected = value!;
                    widget.selection(value, widget.product);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  updateProduct(ProductModel product) async {
    DialogShared.loadingDialog(context, "Updating");
    bool updated = await ProductServices().updateProduct(product);
    Navigator.pop(context);
    if (updated) {
      Fluttertoast.showToast(msg: "Updated");
    } else {
      Fluttertoast.showToast(msg: "Not Updated");
    }
  }

  
}



