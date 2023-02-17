import 'package:ecommerce_store/screens/web_admin/web_Main.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:ecommerce_store/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WebAdminLogInScreen extends StatelessWidget {
  const WebAdminLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String email = 'admin@gmail.com';
    String password = 'admin123';
    submit() {
      if (formKey.currentState!.validate()) {
        if (_emailController.text == email &&
            _passwordController.text == password) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const WebMainScreen()));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WELCOME ADMIN!',
                      style: EcommerceStore.boldStyle,
                    ),
                    const Text(
                      'Log In to Admin Panel!',
                      style: EcommerceStore.boldStyle,
                    ),
                    EcoTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    EcoTextField(
                      controller: _passwordController,
                      isPassword: true,
                      hintText: 'Password',
                    ),
                    EcoButton(
                      isLogIn: true,
                      onPress: submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
