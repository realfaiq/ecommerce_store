import 'package:ecommerce_store/utils/styles.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatelessWidget {
  static const String routeName = 'updateproduct';
  const UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Update Product',
          style: EcommerceStore.boldStyle,
        ),
      ),
    );
  }
}
