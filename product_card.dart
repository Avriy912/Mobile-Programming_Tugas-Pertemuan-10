import 'package:flutter/material.dart';

import '../models/product_item.dart';
import '../utils/currency.dart';

class ProductCard extends StatelessWidget {
  final ProductItem product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(product.category),

            const SizedBox(height: 8),

            Text(
              Currency.rupiah(product.price),
            ),

            const SizedBox(height: 8),

            Text("Stok : ${product.stock}"),

            const Spacer(),

            Row(
              children: [

                Icon(
                  product.trend == "up"
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: product.trend == "up"
                      ? Colors.green
                      : Colors.red,
                ),

                const SizedBox(width: 5),

                Text(product.trend),

              ],
            )

          ],
        ),
      ),
    );
  }
}