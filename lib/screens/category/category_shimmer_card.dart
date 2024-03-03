import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerCard extends StatefulWidget {
  const CategoryShimmerCard({super.key});

  @override
  State<CategoryShimmerCard> createState() => _CategoryShimmerCardState();
}

class _CategoryShimmerCardState extends State<CategoryShimmerCard> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 20,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}