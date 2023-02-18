import 'package:ecommerce_store/utils/styles.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName = 'dashbaord';
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Dashboard',
          style: EcommerceStore.boldStyle,
        ),
      ),
    );
  }
}
