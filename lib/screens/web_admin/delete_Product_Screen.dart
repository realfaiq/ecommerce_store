import 'package:ecommerce_store/utils/styles.dart';
import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  static const String routeName = 'deleteproduct';
  const DeleteProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Delete Product',
          style: EcommerceStore.boldStyle,
        ),
      ),
    );
  }
}
