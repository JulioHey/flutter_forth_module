import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

import '../providers/products.provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);

    final products = productData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) {
        return ProductItem(
          products[index].imageUrl,
          products[index].title,
          products[index].id,
        );
      },
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}