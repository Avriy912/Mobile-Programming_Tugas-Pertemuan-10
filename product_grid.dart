import 'package:flutter/material.dart';

import '../models/product_item.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {

  final List<ProductItem> products;
  final bool isTablet;

  const ProductGrid({
    super.key,
    required this.products,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: products.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: isTablet ? 3 : 2,

        crossAxisSpacing: 12,

        mainAxisSpacing: 12,

        childAspectRatio: .78,

      ),

      itemBuilder: (context, index) {

        return ProductCard(
          product: products[index],
        );

      },

    );

  }
}