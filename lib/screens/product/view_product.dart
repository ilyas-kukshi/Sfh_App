// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';

class ViewProduct extends StatefulWidget {
  ProductModel product;
  ViewProduct({super.key, required this.product});

  @override
  State<ViewProduct> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppThemeShared.appBar(title: "", context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              Carousel(
                height: 250,
                isUrl: true,
                imageUrls: widget.product.imageUris,
                files: const [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
