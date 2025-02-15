import 'package:flutter/material.dart';

class NoProductsAlert extends StatelessWidget {
  const NoProductsAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset('assets/images/noproducts.png')),
        Center(
          child: Text(
            "We will soon add more products here.",
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
