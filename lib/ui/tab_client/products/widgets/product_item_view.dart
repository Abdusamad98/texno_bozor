import 'dart:io';

import 'package:flutter/material.dart';
import 'package:texno_bozor/data/models/product/product_model.dart';


class ProductItemView extends StatelessWidget {
  const ProductItemView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.file(
            File(productModel.productImages[0]),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(productModel.productName)
        ],
      ),
    );
  }
}
