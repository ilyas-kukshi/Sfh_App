import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer {
  Widget productShimmerVertical(BuildContext context) {
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
}