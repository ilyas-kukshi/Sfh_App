import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/address/address_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/order/order_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummary extends ConsumerStatefulWidget {
  final AddressModel address;
  const OrderSummary({super.key, required this.address});

  @override
  ConsumerState<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends ConsumerState<OrderSummary> {
  List<ProductModel> products = [];
  int price = 0;
  int discount = 0;
  int finalPrice = 0;
  String finalAddress = '';

  String getTotalPrice() {
    price = 0;
    for (var element in products) {
      price += element.price;
    }
    return price.toString();
  }

  int getDiscount() {
    discount = 0;
    for (var element in products) {
      discount += element.discount;
    }
    return discount;
  }

  @override
  void initState() {
    super.initState();
    finalAddress =
        '${widget.address.houseNo}, ${widget.address.roadName}, ${widget.address.landmark ?? ''}, ${widget.address.city}, ${widget.address.state} - ${widget.address.pincode}';
  }

  @override
  Widget build(BuildContext context) {
    // final products = ref.read(orderListNotifierProvider);
    products = ref.watch(orderListNotifierProvider);

    return Scaffold(
        // backgroundColor: Colors.grey.withOpacity(0.9),
        appBar: AppThemeShared.appBar(title: "Order Summary", context: context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deliver to:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.address.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                          "${widget.address.houseNo}, ${widget.address.roadName}, ${widget.address.landmark ?? ''}, ${widget.address.city}, ${widget.address.state} - ${widget.address.pincode}"),
                    ),
                    const SizedBox(height: 4),
                    Text("+${widget.address.phoneNumber}"),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              const Divider(color: Colors.grey),
              // const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Products:",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return productCard(products[index]);
                },
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.grey),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Text(
              //     "Payment Type:",
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              // Row(
              //   children: [
              //     Radio(
              //       value: true,
              //       groupValue: true,
              //       activeColor: AppThemeShared.primaryColor,
              //       onChanged: (value) {},
              //     ),
              //     const SizedBox(width: 12),
              //     Text(
              //       "UPI",
              //       style: Theme.of(context)
              //           .textTheme
              //           .titleMedium!
              //           .copyWith(fontSize: 18),
              //     )
              //   ],
              // )
            ],
          ),
        ),
        bottomNavigationBar: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${getTotalPrice()}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                        ),
                        Text(
                          "₹${price - getDiscount()}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 24, fontWeight: FontWeight.bold),
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
                  buttonText: "Pay",
                  onTap: () async {
                    // String upiLink =
                    //     'upi://pay?pa=ilyaskukshiwala53@okicici&pn=Ilyas Kukshiwala&mc=5411&tn=Payment for Goods&tr=98765&am=${price - discount}&cu=INR';
                    // &tid=12345&tr=98765
                    // initiateUpiPayment(upiLink);
                    // ProductCard().enquireOnWhatsapp(widget.product);
                    List<Uri> deepLinks = [];

                    for (var product in products) {
                      deepLinks.add(Utility().buildDeepLink(
                          "/product", {"productId": product.id!}));

                      String whatsappUrl =
                          "https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeQueryComponent('Products: $deepLinks\n Address:$finalAddress\n Final Price: ${price - discount}\n Total Discount: $discount \n\n I would like to buy these products')}";

                      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                        await launchUrl(Uri.parse(whatsappUrl));
                      }
                    }
                  },
                )
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

  Widget productCard(ProductModel product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 100,
              width: 120,
              // width: MediaQuery.of(context).size.width * 0.25,
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
