import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/screens/product/product_card.dart';
import 'package:tuple/tuple.dart';

class NewArrivalsBanner extends StatefulWidget {
  const NewArrivalsBanner({super.key});

  @override
  State<NewArrivalsBanner> createState() => _NewArrivalsBannerState();
}

class _NewArrivalsBannerState extends State<NewArrivalsBanner> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  List<ProductModel> products = [];
  bool isLoading = false;
  int currentPage = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/newArrivals'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("New Arrivals",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/newArrivals');
                  },
                  child: const CircleAvatar(
                      radius: 15,
                      // backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color(0xff0D1B2A),
                      )),
                )
              ],
            ),
          ),
          // const SizedBox(height: 12),
          products.isNotEmpty
              ? GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 305,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ProductCard(
                        product: products[index],
                      ),
                    );
                  },
                )
              : productGridShimmer(context),
        ],
      ),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    if (isLoading) {
      return [];
    }
    isLoading = true;
    currentPage++;
    Tuple2 data = await ProductServices().getLatest(currentPage, 4);
    // List<ProductModel> newProducts = data.item1 as List<ProductModel>;
    if (data.item1.length != 0) {
      products.addAll(data.item1);
    }

    isLastPage = data.item2;
    isLoading = false;
    // setState(() {
    //   products.addAll(newProducts);
    // });
    setState(() {});
    return products;
  }

  Widget productGridShimmer(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0),
      itemBuilder: (context, index) {
        return ProductShimmer().productShimmerVertical(context);
      },
    );
  }
}
