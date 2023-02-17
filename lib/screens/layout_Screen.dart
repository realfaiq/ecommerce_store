import 'package:ecommerce_store/screens/landing_Screen.dart';
import 'package:ecommerce_store/screens/web_admin/web_Admin_Login_Screen.dart';
import 'package:flutter/material.dart';

class LayOutScreen extends StatelessWidget {
  const LayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 600) {
        return const WebAdminLogInScreen();
      } else {
        return LandingScreen();
      }
    });
  }
}
