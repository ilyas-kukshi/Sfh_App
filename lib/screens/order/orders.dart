import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/order/order_model.dart';
import 'package:sfh_app/services/order/order_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Orders extends StatefulWidget {
  final String token;
  const Orders({super.key, required this.token});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> getOrders() async {
    orders = await OrderService().getMyOrders(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Orders", context: context),
      body: FutureBuilder(
        future: getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return orderCard(orders[index]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget orderCard(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                height: 140,
                width: MediaQuery.of(context).size.width * 0.25,
                imageUrl: order.product.imageUris.first),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.product.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹${order.price}",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.black.withOpacity(0.6),
                                decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹${order.price - order.discount}",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Status: ',
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    TextSpan(
                        text: order.status,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 16,
                            color: AppThemeShared.primaryColor,
                            fontWeight: FontWeight.bold))
                  ])),
                  Text(
                    order.address,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      try {
                        String whatsappUrl =
                            "https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeQueryComponent('Order id: ${order.id}\n Your query:')}";
                        if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                          await launchUrl(Uri.parse(whatsappUrl));
                        }
                      } catch (error) {
                        // print(error);
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppThemeShared.primaryColor, width: 2)),
                      child: Text(
                        'Contact for queries',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
